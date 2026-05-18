
---

# Ansible with Cloud

<img src="../99_misc/.img/logos.png" alt="cloud" style="border-radius:25px;float:right;width:400px;">

---

Cloud providers expose APIs, and Ansible speaks to those APIs through **cloud collections**. This means you can provision and configure cloud resources with the same playbooks you already know how to write.

Topics covered:
- Installing cloud collections
- Dynamic inventory from cloud providers
- Provisioning and configuring cloud instances
- Managing cloud storage
- Lab exercises using the Docker lab to mirror cloud patterns

---

# Cloud Collections

Ansible does not ship with cloud modules built in. You install them via **ansible-galaxy**:

```sh
# AWS
ansible-galaxy collection install amazon.aws

# Google Cloud
ansible-galaxy collection install google.cloud

# Azure
ansible-galaxy collection install azure.azcollection
```

Collections install into `~/.ansible/collections/` by default, or into the path set in `ansible.cfg`:

```ini
[defaults]
collections_path = ./collections
```

---

# Authentication

Each cloud provider uses its own authentication mechanism. Ansible reads credentials from the same places the provider's CLI does.

**AWS** — environment variables or `~/.aws/credentials`:
```sh
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=eu-west-1
```

**GCP** — service account JSON:
```sh
export GCP_AUTH_KIND=serviceaccount
export GCP_SERVICE_ACCOUNT_FILE=/path/to/sa.json
export GCP_PROJECT=my-project-id
```

**Azure** — service principal:
```sh
export AZURE_SUBSCRIPTION_ID=...
export AZURE_CLIENT_ID=...
export AZURE_SECRET=...
export AZURE_TENANT=...
```

---

# Dynamic Inventory

In a cloud environment hosts come and go. Instead of a static `hosts.ini`, Ansible can query the cloud API at runtime.

```ini
# ansible.cfg
[defaults]
inventory = ./inventory_aws_ec2.yml
```

```yaml
# inventory_aws_ec2.yml
plugin: amazon.aws.aws_ec2
regions:
  - eu-west-1
filters:
  instance-state-name: running
  tag:Environment: production
keyed_groups:
  - key: tags.Role
    prefix: role
hostnames:
  - private-ip-address
```

Run it to verify:
```sh
ansible-inventory -i inventory_aws_ec2.yml --list
ansible-inventory -i inventory_aws_ec2.yml --graph
```

---

# Provisioning EC2 Instances

```yaml
---
# provision_ec2.yml
- name: Provision web servers on AWS
  hosts: localhost
  gather_facts: false
  vars:
    region: eu-west-1
    instance_type: t3.micro
    ami_id: ami-0694d931cee176e7d   # Debian 12 in eu-west-1
    key_name: my-keypair
    sg_name: ansible-web-sg

  tasks:
    - name: Create security group
      amazon.aws.ec2_security_group:
        name: "{{ sg_name }}"
        description: Ansible managed web SG
        region: "{{ region }}"
        rules:
          - proto: tcp
            ports: [22, 80, 443]
            cidr_ip: 0.0.0.0/0
      register: sg

    - name: Launch web instances
      amazon.aws.ec2_instance:
        name: "web-{{ item }}"
        region: "{{ region }}"
        instance_type: "{{ instance_type }}"
        image_id: "{{ ami_id }}"
        key_name: "{{ key_name }}"
        security_group: "{{ sg_name }}"
        tags:
          Role: web
          Environment: production
        wait: true
      loop: [1, 2, 3]
      register: ec2

    - name: Print instance IPs
      debug:
        msg: "{{ item.instances[0].private_ip_address }}"
      loop: "{{ ec2.results }}"
```

---

# Configuring Cloud Instances

Once instances exist, target them exactly like local nodes:

```yaml
---
# configure_web.yml
- name: Configure web servers
  hosts: role_web          # from dynamic inventory keyed_group
  become: true
  tasks:
    - name: Install nginx
      ansible.builtin.package:
        name: nginx
        state: present

    - name: Deploy site config
      ansible.builtin.template:
        src: templates/nginx.conf.j2
        dest: /etc/nginx/sites-enabled/default
      notify: Reload nginx

    - name: Ensure nginx is running
      ansible.builtin.service:
        name: nginx
        state: started
        enabled: true

  handlers:
    - name: Reload nginx
      ansible.builtin.service:
        name: nginx
        state: reloaded
```

---

# Managing Cloud Storage (S3)

```yaml
---
# s3_backup.yml
- name: Backup configs to S3
  hosts: localhost
  gather_facts: false
  vars:
    bucket: my-ansible-backups
    region: eu-west-1

  tasks:
    - name: Ensure bucket exists
      amazon.aws.s3_bucket:
        name: "{{ bucket }}"
        region: "{{ region }}"
        versioning: true

    - name: Upload ansible.cfg
      amazon.aws.s3_object:
        bucket: "{{ bucket }}"
        object: backups/ansible.cfg
        src: /etc/ansible/ansible.cfg
        mode: put

    - name: List bucket contents
      amazon.aws.s3_object:
        bucket: "{{ bucket }}"
        mode: list
      register: bucket_contents

    - name: Show contents
      debug:
        var: bucket_contents.s3_keys
```

---

# Terminating Resources

Always include a teardown playbook alongside your provisioning playbook:

```yaml
---
# teardown_ec2.yml
- name: Terminate lab instances
  hosts: localhost
  gather_facts: false
  vars:
    region: eu-west-1

  tasks:
    - name: Find instances tagged for teardown
      amazon.aws.ec2_instance_info:
        region: "{{ region }}"
        filters:
          "tag:Environment": production
          instance-state-name: running
      register: instances

    - name: Terminate instances
      amazon.aws.ec2_instance:
        instance_ids: "{{ item.instance_id }}"
        region: "{{ region }}"
        state: terminated
      loop: "{{ instances.instances }}"
```

---

# Practice — Simulating Cloud Patterns in the Lab

The Docker lab (node1-node5) mirrors a real cloud setup. Treat **node1** and **node3** (Debian) as your *web tier* and **node2** and **node4** (Rocky) as your *db tier*.

**Exercise 1 — Provision-style setup**

Write a playbook that:
- Installs nginx on node1 and node3
- Installs postgresql on node2 and node4
- Creates a `/etc/motd` on every node announcing its role

---

# Practice (cont.)

```yaml
---
# cloud_style_provision.yml
- name: Set up web tier
  hosts: node1,node3
  become: true
  vars:
    role_name: web
  tasks:
    - name: Install nginx
      ansible.builtin.apt:
        name: nginx
        state: present
        update_cache: true

    - name: Set role MOTD
      ansible.builtin.copy:
        content: "This is a {{ role_name }} node — managed by Ansible\n"
        dest: /etc/motd

    - name: Ensure nginx is running
      ansible.builtin.service:
        name: nginx
        state: started
        enabled: true

- name: Set up db tier
  hosts: node2,node4
  become: true
  vars:
    role_name: db
  tasks:
    - name: Install postgresql
      ansible.builtin.dnf:
        name: postgresql-server
        state: present

    - name: Set role MOTD
      ansible.builtin.copy:
        content: "This is a {{ role_name }} node — managed by Ansible\n"
        dest: /etc/motd
```

```sh
ansible-playbook cloud_style_provision.yml
```

---

# Practice — Dynamic-style Inventory

Simulate dynamic inventory by writing a script that generates inventory from the running Docker containers.

```yaml
---
# inventory_docker.yml  (uses community.docker plugin)
plugin: community.docker.docker_containers
docker_host: unix:///var/run/docker.sock
```

Or use a simple static inventory that mirrors what a cloud plugin would produce:

```ini
# hosts.ini
[web]
node1 ansible_user=docker
node3 ansible_user=docker

[db]
node2 ansible_user=docker
node4 ansible_user=docker

[web:vars]
ansible_python_interpreter=/usr/bin/python3

[db:vars]
ansible_python_interpreter=/usr/bin/python3
```

---

# Practice — Rolling Update

Cloud deployments often use rolling updates. Practice the pattern on the lab nodes:

```yaml
---
# rolling_update.yml
- name: Rolling update of web tier
  hosts: web
  become: true
  serial: 1          # one host at a time
  tasks:
    - name: Install latest nginx
      ansible.builtin.package:
        name: nginx
        state: latest

    - name: Verify nginx responds
      ansible.builtin.uri:
        url: http://{{ ansible_host }}
        status_code: 200
      delegate_to: localhost
```

```sh
ansible-playbook rolling_update.yml -i hosts.ini
```

---

# Summary Exercise (no solution)

Using the lab nodes (node1-node5 and node_app), write an end-to-end **"cloud-style deployment"** playbook suite that:

1. Defines a `hosts.ini` with groups: `web` (node1, node3), `db` (node2, node4), `app` (node_app)
2. Writes a **provision** playbook that installs the correct service on each group (nginx / postgresql / your choice for app)
3. Writes a **configure** playbook that:
   - Deploys a Jinja2-rendered config file to each group using group-specific variables
   - Sets a unique `/etc/motd` per group
4. Writes a **teardown** playbook that stops all services and removes installed packages
5. Runs the playbooks in order and verifies each tier is working before moving to the next using `uri` or `wait_for`

> Hint: use `serial`, `delegate_to`, and `handlers` as you would in a real cloud deployment.
