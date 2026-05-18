
---

# Testing Ansible — ansible-lint and Molecule

<img src="../99_misc/.img/gear.png" alt="testing" style="border-radius:25px;float:right;width:400px;">

---

Writing a playbook that runs is not the same as writing a playbook that is correct. Two tools enforce quality before code reaches production:

- **ansible-lint** — static analysis: catches bugs, style issues, and deprecated syntax
- **Molecule** — functional testing: actually runs your role in a container and verifies it works

Topics covered:
- Installing and running ansible-lint
- Reading and fixing lint warnings
- Molecule concepts and workflow
- Writing a Molecule test for a role
- Running Molecule in the Docker lab

---

# ansible-lint

`ansible-lint` reads your playbooks and roles without executing them and reports:
- Deprecated module usage
- Missing `name:` on tasks
- Risky `command`/`shell` usage where a module exists
- YAML formatting issues
- Best-practice violations

Install it:

```sh
pip install ansible-lint
```

---

# Running ansible-lint

```sh
# Lint a single playbook
ansible-lint playbook.yml

# Lint an entire role directory
ansible-lint roles/common/

# Lint everything in the current directory
ansible-lint
```

Example output:

```
WARNING  Listing 3 violation(s) that are fatal
risky-shell-pipe: Shells that use pipes should set the pipefail option
playbook.yml:12 Task/Handler: check disk

no-changed-when: Commands should not change things if nothing needs changing
playbook.yml:18 Task/Handler: restart service

yaml[trailing-spaces]: Trailing spaces
roles/common/tasks/main.yml:5
```

---

# Fixing Lint Warnings

**risky-shell-pipe** — add `pipefail`:

```yaml
# Before
- name: Check disk
  ansible.builtin.shell: df -h | grep /data

# After
- name: Check disk
  ansible.builtin.shell: df -h | grep /data
  args:
    executable: /bin/bash
  changed_when: false
```

**no-changed-when** — tell Ansible when the task changes something:

```yaml
# Before
- name: Restart service
  ansible.builtin.command: systemctl restart nginx

# After — use the service module instead
- name: Restart nginx
  ansible.builtin.service:
    name: nginx
    state: restarted
```

---

# Practice — Lint the Course Playbooks

Run `ansible-lint` against an existing chapter and fix the warnings:

```sh
cd ~/ansible_course
ansible-lint 07_tags/00.yaml
```

Common fixes you will likely need:
- Add `changed_when: false` to `command` tasks that only read state
- Replace bare `command: systemctl ...` with the `service` module
- Add missing `name:` to plays that lack one

```sh
# Re-run after fixing to confirm zero violations
ansible-lint 07_tags/00.yaml
echo "Exit code: $?"   # 0 = clean
```

---

# Configuring ansible-lint

Create `.ansible-lint` in your project root to tune behaviour:

```yaml
# .ansible-lint
profile: production      # or: min, basic, moderate, safety, shared

skip_list:
  - yaml[line-length]   # ignore long lines

warn_list:
  - experimental

exclude_paths:
  - 99_misc/
  - out/
```

Profiles in order of strictness: `min` → `basic` → `moderate` → `safety` → `shared` → `production`

---

# Molecule

Molecule drives your role through a full lifecycle in an isolated environment and then runs assertions to prove it worked.

The lifecycle:

```
molecule create   → spin up test instance(s)
molecule converge → run the role against them
molecule verify   → run assertions (testinfra or ansible)
molecule destroy  → tear down instances
molecule test     → all of the above in sequence
```

---

# Installing Molecule

```sh
pip install molecule molecule-plugins[docker]
```

The `docker` driver uses Docker containers as test instances — perfect for the course lab which already uses Docker.

Verify:
```sh
molecule --version
```

---

# Initialising Molecule in a Role

```sh
cd roles/common
molecule init scenario --driver-name docker
```

This creates:

```
roles/common/
└── molecule/
    └── default/
        ├── molecule.yml     ← driver and platform config
        ├── converge.yml     ← playbook that applies the role
        └── verify.yml       ← assertions
```

---

# molecule.yml

```yaml
# molecule/default/molecule.yml
---
dependency:
  name: galaxy

driver:
  name: docker

platforms:
  - name: instance-debian
    image: debian:12
    pre_build_image: true
    command: /bin/bash
    tty: true

  - name: instance-rocky
    image: rockylinux/rockylinux:9.3
    pre_build_image: true
    command: /bin/bash
    tty: true

provisioner:
  name: ansible

verifier:
  name: ansible
```

---

# converge.yml

The converge playbook applies your role to the test instances. Keep it minimal:

```yaml
# molecule/default/converge.yml
---
- name: Converge
  hosts: all
  become: true
  roles:
    - role: common
```

---

# verify.yml

The verify playbook asserts the expected state after the role has run:

```yaml
# molecule/default/verify.yml
---
- name: Verify
  hosts: all
  become: true
  tasks:
    - name: Gather package facts
      ansible.builtin.package_facts:

    - name: Assert vim is installed
      ansible.builtin.assert:
        that:
          - "'vim-nox' in ansible_facts.packages or 'vim' in ansible_facts.packages"
        fail_msg: "vim is not installed"

    - name: Assert MOTD is set
      ansible.builtin.slurp:
        src: /etc/motd
      register: motd

    - name: Check MOTD content
      ansible.builtin.assert:
        that:
          - "'Ansible' in motd.content | b64decode"
        fail_msg: "MOTD does not contain expected text"
```

---

# Running Molecule

```sh
cd roles/common

# Full test sequence (create → converge → verify → destroy)
molecule test

# Iterative development — keep instance running
molecule create
molecule converge
molecule verify

# Re-run just the role after editing it
molecule converge

# Log into the test instance to inspect manually
molecule login --host instance-debian

# Clean up
molecule destroy
```

---

# Practice — Test the common Role

The course has a `common` role in `08_roles/roles/common/`. Add Molecule to it:

```sh
cd 08_roles/roles/common
molecule init scenario --driver-name docker
```

Edit `molecule/default/verify.yml` to assert that:
- The packages listed in `common/defaults/main.yml` are installed
- Any service started by the role is running and enabled

Then run the full test:

```sh
molecule test
```

---

# Practice — TDD with Molecule

Write the **verify assertions first**, then write the role tasks to make them pass.

1. Init a new role:
```sh
ansible-galaxy role init roles/motd_role
cd roles/motd_role
molecule init scenario --driver-name docker
```

2. Write `verify.yml` asserting `/etc/motd` contains the string `"Ansible managed"` and the file is owned by root.

3. Write `tasks/main.yml` to make the assertions pass.

4. Run `molecule test` — green means done.

This is the Red → Green → Refactor cycle applied to infrastructure.

---

# Integrating lint and Molecule into CI

Add both checks to your GitLab CI or GitHub Actions pipeline so they run on every push:

```yaml
# .gitlab-ci.yml
stages:
  - lint
  - test

ansible-lint:
  stage: lint
  image: python:3.11
  script:
    - pip install ansible-lint
    - ansible-lint
  rules:
    - changes:
        - "**/*.yml"
        - "**/*.yaml"

molecule:
  stage: test
  image: python:3.11
  services:
    - docker:dind
  variables:
    DOCKER_HOST: tcp://docker:2375
  script:
    - pip install ansible molecule molecule-plugins[docker]
    - cd 08_roles/roles/common
    - molecule test
```

---

# Summary Exercise (no solution)

Using the `clone_repo` role from `08_roles/roles/clone_repo`:

1. Run `ansible-lint` against the role and fix all violations (aim for zero warnings with the `moderate` profile)
2. Add Molecule to the role with two platforms: `debian:12` and `rockylinux/rockylinux:9.3`
3. Write a `verify.yml` that asserts:
   - `git` is installed on the test instance
   - The target clone directory exists and is a git repository (check for a `.git` subdirectory)
   - The cloned repo's remote URL matches the one passed as a variable
4. Run `molecule test` and confirm both platforms pass
5. Write a `.ansible-lint` config that excludes `99_misc/` and `out/` and uses the `moderate` profile, then run `ansible-lint` across the whole project
