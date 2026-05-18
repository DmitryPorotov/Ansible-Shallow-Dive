
---

# Lookup Plugins

---

# Lookup Plugins

Lookups let you pull data **into** a playbook from outside sources — files, environment variables, password stores, CSV files, and more. They run on the **control node**, not on the remote host.

```yaml
"{{ lookup('plugin_name', 'argument') }}"
```

Topics covered:
- `file` — read a local file
- `env` — read environment variables
- `password` — generate or retrieve passwords
- `template` — render a Jinja2 file as a string
- `csvfile` — query a CSV file
- `dict` and `items` — iterate with lookups

---

# file

Read the contents of a file on the control node into a variable:

```yaml
---
- name: Lookup file examples
  hosts: node1
  vars:
    pub_key: "{{ lookup('file', '~/.ssh/id_rsa.pub') }}"
  tasks:
    - name: Authorise control node key on host
      ansible.builtin.authorized_key:
        user: docker
        key: "{{ pub_key }}"

    - name: Deploy a local config file as content
      ansible.builtin.copy:
        content: "{{ lookup('file', 'files/nginx.conf') }}"
        dest: /etc/nginx/nginx.conf
```

The path is relative to the playbook directory, or you can use an absolute path.

---

# env

Read an environment variable from the control node:

```yaml
---
- name: Env lookup examples
  hosts: all
  vars:
    deploy_user: "{{ lookup('env', 'USER') }}"
    deploy_env:  "{{ lookup('env', 'DEPLOY_ENV') | default('staging') }}"
  tasks:
    - name: Write deploy info to MOTD
      ansible.builtin.copy:
        content: "Deployed by {{ deploy_user }} to {{ deploy_env }}\n"
        dest: /etc/motd
      become: true
```

```sh
DEPLOY_ENV=production ansible-playbook env_demo.yml -i hosts.ini
```

---

# Practice — file + env

Using node1 and node3 (Debian), write a playbook that:
- Reads the SSH public key from `../99_misc/setup/docker/id_rsa.pub` using `lookup('file', ...)`
- Reads a `DEPLOY_VERSION` environment variable (default to `1.0.0` if not set)
- Writes both values into `/etc/deploy_info` on the targets

```yaml
---
# lookup_practice.yml
- name: Deploy info
  hosts: node1,node3
  become: true
  vars:
    ssh_key:        "{{ lookup('file', '../99_misc/setup/docker/id_rsa.pub') }}"
    deploy_version: "{{ lookup('env', 'DEPLOY_VERSION') | default('1.0.0') }}"
  tasks:
    - name: Write deploy info
      ansible.builtin.copy:
        content: |
          Version: {{ deploy_version }}
          Key:     {{ ssh_key }}
        dest: /etc/deploy_info
```

```sh
DEPLOY_VERSION=2.1.0 ansible-playbook lookup_practice.yml -i hosts.ini
```

---

# Password

Generate a random password and store it in a file on the control node. If the file already exists the same password is returned — making this idempotent.

```yaml
---
- name: Password lookup
  hosts: node2
  become: true
  vars:
    db_pass: "{{ lookup('password', 'credentials/db_password length=20 chars=ascii_letters,digits') }}"
  tasks:
    - name: Create postgres user with generated password
      ansible.builtin.user:
        name: dbadmin
        password: "{{ db_pass | password_hash('sha512') }}"
```

The password is saved to `credentials/db_password` on the control node. Commit that file to vault, not to plain git.

---

# Template

Render a Jinja2 template file on the control node and use the result as a string (rather than writing it directly to a file):

```yaml
---
- name: Template lookup
  hosts: all
  become: true
  vars:
    app_name: myapp
    app_port: 8080
  tasks:
    - name: Deploy rendered config
      ansible.builtin.copy:
        content: "{{ lookup('template', 'templates/app.conf.j2') }}"
        dest: /etc/myapp/app.conf
```

```
# templates/app.conf.j2
[app]
name = {{ app_name }}
port = {{ app_port }}
host = {{ inventory_hostname }}
```

---

# Csvfile

Query a value from a CSV file by key. Useful for maintaining host-specific data in a spreadsheet:

```csv
# data/hosts.csv
hostname,ip,role,owner
node1,172.20.0.2,web,alice
node2,172.20.0.3,db,bob
node3,172.20.0.4,web,alice
node4,172.20.0.5,db,charlie
```

```yaml
---
- name: CSV lookup
  hosts: all
  tasks:
    - name: Show host owner from CSV
      ansible.builtin.debug:
        msg: >
          {{ inventory_hostname }} is owned by
          {{ lookup('csvfile', inventory_hostname + ' file=data/hosts.csv col=3 delimiter=,') }}
```

---

# Lookups in loops

Lookups integrate naturally with `loop`:

```yaml
---
- name: Add authorised keys from a list of files
  hosts: all
  become: true
  tasks:
    - name: Authorise team keys
      ansible.builtin.authorized_key:
        user: docker
        key: "{{ lookup('file', item) }}"
      loop:
        - keys/alice.pub
        - keys/bob.pub
        - keys/charlie.pub
```

Or use `with_fileglob` to pick up all keys in a directory:

```yaml
    - name: Authorise all keys in keys/
      ansible.builtin.authorized_key:
        user: docker
        key: "{{ lookup('file', item) }}"
      with_fileglob:
        - keys/*.pub
```

---

# Summary Exercise (no solution)

Write a playbook called `onboard_node.yml` that uses **at least three different lookup plugins** to onboard a new node into the lab:

1. Use `lookup('password', ...)` to generate a unique password for a new user `ansible_student` on every target host
2. Use `lookup('file', ...)` to read the lab SSH public key and authorise it for `ansible_student`
3. Use `lookup('env', 'STUDENT_NAME')` to set the user's GECOS field (full name) — default to `"Lab Student"` if the variable is not set
4. Use `lookup('template', ...)` to render and deploy a welcome message to `/etc/motd` that includes the student's name, the hostname, and today's date
5. Run the playbook against node1 and node2, passing `STUDENT_NAME=Alice` on the first run and `STUDENT_NAME=Bob` on the second run, and verify the MOTD differs on each host
