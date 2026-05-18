
---

# Ansible Troubleshooting

<img src="../99_misc/.img/gear.png" alt="troubleshooting" style="border-radius:25px;float:right;width:400px;">

---

Things go wrong. Knowing how to diagnose a failing playbook quickly is what separates a beginner from a confident Ansible practitioner.

Topics covered:
- Verbosity levels
- The `debug` module
- The `assert` module
- Check mode and diff mode
- The `register` + `debug` pattern
- Blocks with `rescue`
- Common errors and their fixes

---

# Verbosity Levels

The single most useful troubleshooting tool is just adding `-v` flags to `ansible-playbook`. Each extra `v` reveals more detail:

| Flag | Shows |
|------|-------|
| `-v` | Task results |
| `-vv` | Input arguments to each task |
| `-vvv` | SSH connection details |
| `-vvvv` | Full connection plugin debug output |

```sh
ansible-playbook playbook.yml -v
ansible-playbook playbook.yml -vvv
```

Start with `-v` and only go deeper if you need it.

---

# The debug Module

`debug` prints a message or the value of a variable during a playbook run without changing anything on the target host.

```yaml
---
- name: Debug examples
  hosts: node1
  become: true
  tasks:
    - name: Show a static message
      ansible.builtin.debug:
        msg: "Reached this point in the playbook"

    - name: Show a variable
      ansible.builtin.debug:
        var: ansible_distribution

    - name: Show multiple facts
      ansible.builtin.debug:
        msg: "Host {{ inventory_hostname }} runs {{ ansible_os_family }} {{ ansible_distribution_version }}"
```

```sh
ansible-playbook debug_example.yml
```

---

# register + debug

`register` captures the output of any task into a variable. Combined with `debug` you can inspect exactly what a module returned.

```yaml
---
- name: Register and inspect
  hosts: node1
  become: true
  tasks:
    - name: Check disk space
      ansible.builtin.command: df -h /
      register: disk_output

    - name: Show raw output
      ansible.builtin.debug:
        var: disk_output

    - name: Show only stdout
      ansible.builtin.debug:
        msg: "{{ disk_output.stdout }}"

    - name: Check if a service is active
      ansible.builtin.command: systemctl is-active ssh
      register: ssh_status
      ignore_errors: true

    - name: Show service status
      ansible.builtin.debug:
        msg: "SSH service status: {{ ssh_status.stdout }}"
```

---

# Practice — register + debug

Run this playbook against node2 (Rocky Linux) and inspect the output:

```yaml
---
# inspect_node.yml
- name: Inspect node2
  hosts: node2
  become: true
  tasks:
    - name: Gather package list
      ansible.builtin.command: rpm -qa --last
      register: packages

    - name: Show first 10 packages
      ansible.builtin.debug:
        msg: "{{ packages.stdout_lines[:10] }}"

    - name: Check uptime
      ansible.builtin.command: uptime
      register: uptime_result

    - name: Show uptime
      ansible.builtin.debug:
        var: uptime_result.stdout
```

```sh
ansible-playbook inspect_node.yml -i hosts.ini
```

---

# The assert Module

`assert` stops a playbook immediately if a condition is not met. Use it to validate state before continuing:

```yaml
---
- name: Assert examples
  hosts: node1
  become: true
  tasks:
    - name: Confirm OS family
      ansible.builtin.assert:
        that:
          - ansible_os_family == "Debian"
        fail_msg: "This playbook only runs on Debian systems"
        success_msg: "OS check passed"

    - name: Check free memory
      ansible.builtin.assert:
        that:
          - ansible_memfree_mb > 50
        fail_msg: "Not enough free memory: {{ ansible_memfree_mb }} MB"
```

A failed `assert` stops execution immediately — ideal for pre-flight checks.

---

# Practice — assert

Write a pre-flight check playbook that validates the lab before running any deployment:

```yaml
---
# preflight.yml
- name: Pre-flight checks
  hosts: all
  gather_facts: true
  tasks:
    - name: Python is available
      ansible.builtin.assert:
        that:
          - ansible_python_version is defined
        fail_msg: "Python not found on {{ inventory_hostname }}"

    - name: SSH port is 22
      ansible.builtin.assert:
        that:
          - ansible_port | default(22) == 22
        fail_msg: "Unexpected SSH port on {{ inventory_hostname }}"

    - name: Enough disk on root
      ansible.builtin.assert:
        that:
          - (ansible_mounts | selectattr('mount','equalto','/') | list | first).size_available > 500000000
        fail_msg: "Less than 500 MB free on / for {{ inventory_hostname }}"
        success_msg: "Disk check OK on {{ inventory_hostname }}"
```

```sh
ansible-playbook preflight.yml -i hosts.ini
```

---

# Check Mode (Dry Run)

Check mode runs a playbook without making any actual changes. Tasks that would make a change report `changed` and tasks that would not report `ok` — nothing is applied.

```sh
ansible-playbook playbook.yml --check
```

Combine with `--diff` to also show exactly what would change in files:

```sh
ansible-playbook playbook.yml --check --diff
```

> Not all modules support check mode. Modules that run raw commands (`command`, `shell`) always report `changed` in check mode.

---

# Practice — check + diff

```yaml
---
# motd_check.yml
- name: Update MOTD
  hosts: all
  become: true
  tasks:
    - name: Set MOTD
      ansible.builtin.copy:
        content: "Managed by Ansible — {{ ansible_date_time.date }}\n"
        dest: /etc/motd
```

Run first in check+diff mode, then for real:

```sh
# See what would change
ansible-playbook motd_check.yml -i hosts.ini --check --diff

# Apply
ansible-playbook motd_check.yml -i hosts.ini
```

---

# Blocks with rescue

`block` groups tasks together so you can catch failures with `rescue` — similar to try/except in Python:

```yaml
---
- name: Error handling with blocks
  hosts: node1
  become: true
  tasks:
    - block:
        - name: Install package that may not exist
          ansible.builtin.apt:
            name: does-not-exist
            state: present

        - name: This will not run if above fails
          ansible.builtin.debug:
            msg: "Package installed successfully"

      rescue:
        - name: Handle the failure
          ansible.builtin.debug:
            msg: "Package install failed — running fallback"

        - name: Install a known-good package instead
          ansible.builtin.apt:
            name: curl
            state: present

      always:
        - name: This always runs
          ansible.builtin.debug:
            msg: "Block finished (success or failure)"
```

---

# Practice — rescue in the lab

Simulate a failure and recover on node1:

```yaml
---
# rescue_demo.yml
- name: Deploy app with rescue
  hosts: node1
  become: true
  tasks:
    - block:
        - name: Try to start a non-existent service
          ansible.builtin.service:
            name: my_fake_app
            state: started

      rescue:
        - name: Log the failure
          ansible.builtin.copy:
            content: "Service start failed at {{ ansible_date_time.iso8601 }}\n"
            dest: /var/log/ansible_errors.log

        - name: Notify via debug (in real life send an alert)
          ansible.builtin.debug:
            msg: "Rescue triggered — check /var/log/ansible_errors.log"

      always:
        - name: Confirm host is still reachable
          ansible.builtin.ping:
```

```sh
ansible-playbook rescue_demo.yml -i hosts.ini
```

---

# Common Errors and Fixes

| Error | Likely cause | Fix |
|-------|-------------|-----|
| `UNREACHABLE` | SSH not reachable | Check `ansible_host`, SSH keys, `sshd` running |
| `MODULE FAILURE` | Wrong Python or missing module | Verify `ansible_python_interpreter` |
| `Permission denied` | Not using `become` | Add `become: true` to play or task |
| `Timeout` | Slow host or wrong port | Increase `timeout` in `ansible.cfg` |
| `undefined variable` | Variable not set | Use `default()` filter: `{{ my_var \| default('fallback') }}` |
| `changed` every run | Non-idempotent module | Use `creates`/`removes` with `command`, or switch to idempotent module |
| `Syntax error` | Bad YAML | Run `ansible-playbook --syntax-check playbook.yml` |

---

# Syntax Check and List Tasks

Two quick commands to inspect a playbook before running it:

```sh
# Validate YAML and Ansible syntax
ansible-playbook playbook.yml --syntax-check

# List all tasks that would run (no execution)
ansible-playbook playbook.yml --list-tasks

# List all hosts that would be targeted
ansible-playbook playbook.yml --list-hosts
```

Always run `--syntax-check` before running a new playbook against production nodes.

---

# Step Mode

Run one task at a time and confirm each step interactively. Useful when you are not sure where a failure happens:

```sh
ansible-playbook playbook.yml --step
```

Ansible will prompt `Perform task: <task name> (y/n/c)?` before each task. Press `y` to run, `n` to skip, `c` to continue without prompting.

---

# Summary Exercise (no solution)

Using the lab (node1-node5), write a **diagnostic playbook** called `diagnose.yml` that:

1. Runs against **all** hosts
2. Uses `assert` to verify that:
   - Python is present
   - The host has more than 100 MB of free memory
   - The root filesystem has more than 200 MB free
3. Uses `register` + `debug` to capture and display:
   - The running kernel version (`uname -r`)
   - The last 5 lines of `/var/log/auth.log` (Debian) or `/var/log/secure` (Rocky) — handle both distributions with `when`
4. Wraps the log-reading task in a `block`/`rescue` so that if the log file does not exist the playbook prints a warning and continues rather than failing
5. Runs the whole playbook in `--check --diff` mode first, then for real
6. At the end, uses `debug` to print a summary per host: OS, free memory, and kernel version

> Tip: use `ansible_os_family` to handle Debian vs Rocky differences, and `ansible_memfree_mb` for memory facts.
