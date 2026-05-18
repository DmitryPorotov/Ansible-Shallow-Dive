
---

# Ansible Performance Tuning

<img src="../99_misc/.img/setup.png" alt="performance" style="border-radius:25px;float:right;width:400px;">

---

A playbook that takes 2 minutes to run against 5 hosts can take 20 minutes against 50. Understanding how Ansible executes tasks lets you cut that time dramatically without changing what the playbook does.

Topics covered:
- Forks — parallel host execution
- SSH pipelining
- `async` and `poll` — non-blocking tasks
- `strategy: free`
- Fact caching
- The `profile_tasks` callback

---

# Forks

By default Ansible runs tasks against **5 hosts at a time** (forks = 5). Every other host waits.

Increase forks in `ansible.cfg`:

```ini
[defaults]
forks = 20
```

Or override at runtime:

```sh
ansible-playbook playbook.yml -f 20
```

**Rule of thumb:** set forks to the number of hosts you typically target, up to the CPU/network limit of your control node. Values between 10 and 50 cover most use cases.

---

# SSH Pipelining

By default Ansible:
1. Opens an SSH connection
2. Copies a Python script to the remote host via SFTP
3. Runs the script
4. Deletes the script
5. Closes the connection

With **pipelining** enabled, steps 2 and 4 (file copy and delete) are skipped — the script is piped directly over the existing SSH connection.

Enable in `ansible.cfg`:

```ini
[ssh_connection]
pipelining = True
```

> Requires `requiretty` to be disabled in `/etc/sudoers` on target hosts (which is the case in the lab — check with `grep requiretty /etc/sudoers`).

Pipelining typically cuts task execution time by **30–50%**.

---

# Practice — measure the difference

The lab has 5 nodes. Measure the impact of forks and pipelining:

```sh
# Baseline (forks=5, no pipelining)
time ansible-playbook 02_fundamentals/... -i hosts.ini

# With higher forks
time ansible-playbook 02_fundamentals/... -i hosts.ini -f 10

# Add pipelining to ansible.cfg, then:
time ansible-playbook 02_fundamentals/... -i hosts.ini -f 10
```

Record the times and compare.

---

# async and poll

Some tasks take a long time (package installs, compilations, reboots). By default Ansible waits for each task to finish on every host before moving on. `async` changes that.

```yaml
---
- name: Async example
  hosts: all
  become: true
  tasks:
    - name: Run long operation in background
      ansible.builtin.apt:
        name: build-essential
        state: present
        update_cache: true
      async: 300      # maximum seconds to wait
      poll: 0         # 0 = fire and forget (don't wait)
      register: install_job

    - name: Do other work while install runs
      ansible.builtin.debug:
        msg: "Install is running in background, job id: {{ install_job.ansible_job_id }}"

    - name: Wait for install to finish
      ansible.builtin.async_status:
        jid: "{{ install_job.ansible_job_id }}"
      register: job_result
      until: job_result.finished
      retries: 30
      delay: 10
```

---

# async with poll > 0

Setting `poll` to a positive number makes Ansible check every N seconds until done — useful when you want to block but still show progress:

```yaml
    - name: Install package (check every 5s, timeout after 5m)
      ansible.builtin.dnf:
        name: postgresql-server
        state: present
      async: 300
      poll: 5
```

| `poll` value | Behaviour |
|-------------|-----------|
| `0` | Fire and forget — collect result later with `async_status` |
| `> 0` | Poll every N seconds until done or timeout |
| omitted | Synchronous (default) |

---

# Practice — async install

On node2 and node4 (Rocky Linux), install `postgresql-server` asynchronously while simultaneously installing `vim` on node1 and node3 (Debian):

```yaml
---
# async_practice.yml
- name: Async cross-platform install
  hosts: all
  become: true
  tasks:
    - name: Install heavy package (async)
      ansible.builtin.package:
        name: "{{ 'postgresql-server' if ansible_os_family == 'RedHat' else 'postgresql' }}"
        state: present
      async: 300
      poll: 0
      register: pkg_job

    - name: Install vim while waiting
      ansible.builtin.package:
        name: vim
        state: present

    - name: Wait for heavy package
      ansible.builtin.async_status:
        jid: "{{ pkg_job.ansible_job_id }}"
      register: result
      until: result.finished
      retries: 30
      delay: 10
```

```sh
time ansible-playbook async_practice.yml -i hosts.ini
```

---

# strategy: free

The default strategy is `linear` — every host must finish a task before any host moves to the next task.

`free` lets each host race ahead independently:

```yaml
---
- name: Free strategy example
  hosts: all
  strategy: free
  become: true
  tasks:
    - name: Update package cache
      ansible.builtin.package:
        update_cache: true

    - name: Install nginx
      ansible.builtin.package:
        name: nginx
        state: present

    - name: Start nginx
      ansible.builtin.service:
        name: nginx
        state: started
```

Use `free` when tasks are independent across hosts and order does not matter. Avoid it when a later task on one host depends on an earlier task finishing on another.

---

# Fact Caching

Gathering facts (`gather_facts: true`) runs the `setup` module on every host at the start of every play. On large inventories this adds seconds per host.

**Option 1 — Disable fact gathering when you don't need it:**

```yaml
- name: Quick task
  hosts: all
  gather_facts: false
  tasks:
    - name: Ping
      ansible.builtin.ping:
```

**Option 2 — Cache facts so they are only gathered once:**

```ini
# ansible.cfg
[defaults]
gathering        = smart          # only gather if not cached
fact_caching     = jsonfile
fact_caching_connection = /tmp/ansible_facts_cache
fact_caching_timeout    = 3600   # seconds
```

With `gathering = smart`, facts are gathered once and reused for 1 hour across all playbook runs.

---

# Practice — fact caching

Enable fact caching in `ansible.cfg`, then compare:

```sh
# First run — gathers and caches facts
time ansible-playbook 03_playbooks/... -i hosts.ini

# Second run — reads from cache (should be faster)
time ansible-playbook 03_playbooks/... -i hosts.ini

# Inspect the cache
ls -lh /tmp/ansible_facts_cache/
cat /tmp/ansible_facts_cache/node1
```

Clear the cache manually:
```sh
rm -rf /tmp/ansible_facts_cache/
```

---

# profile_tasks Callback

Enable the built-in `profile_tasks` callback to see how long each task takes:

```ini
# ansible.cfg
[defaults]
callbacks_enabled = profile_tasks
```

Output after a playbook run:

```
Monday 01 January 2025  12:00:05 +0000 (0:00:03.412)  0:00:03.412 ****
===============================================================================
Install nginx ---------------------------------------------------------- 2.31s
Update package cache --------------------------------------------------- 0.84s
Start nginx ------------------------------------------------------------ 0.27s
```

Use this to identify the slowest tasks and decide where to apply `async`, pipelining, or caching.

---

# Practice — profile and optimise

Run the provision playbook from chapter 12 with `profile_tasks` enabled:

```sh
ansible-playbook 12_ansible_and_cloud/cloud_style_provision.yml \
  -i hosts.ini \
  -e "callbacks_enabled=profile_tasks"
```

Identify the two slowest tasks, then:
1. Make package installs async where possible
2. Enable pipelining
3. Increase forks to match the number of hosts

Re-run and compare total wall-clock time.

---

# Summary of Tuning Options

| Technique | Where to set | Typical gain |
|-----------|-------------|-------------|
| Increase forks | `ansible.cfg` or `-f` | Large — proportional to host count |
| SSH pipelining | `ansible.cfg` | 30–50% per task |
| `async` + `poll: 0` | Per task | Eliminates sequential waits |
| `strategy: free` | Per play | Removes cross-host synchronisation |
| Fact caching | `ansible.cfg` | Saves ~1s per host per run |
| `gather_facts: false` | Per play | Saves ~0.5–2s per host |

Start with **forks + pipelining** — they are always safe and deliver the biggest improvement for the least effort.

---

# Summary Exercise (no solution)

Using the full lab (node1–node5 and node_app), write an **optimised deployment playbook** called `optimised_deploy.yml` that:

1. Sets `strategy: free` at the play level
2. Uses `gather_facts: true` but with fact caching enabled in `ansible.cfg` (set timeout to 1800 seconds)
3. Installs nginx (Debian nodes) and httpd (Rocky nodes) **asynchronously** (fire-and-forget with `poll: 0`)
4. While the installs run in background, deploys a custom `/etc/motd` on all hosts synchronously
5. Uses `async_status` to wait for all installs to complete before proceeding
6. Enables the `profile_tasks` callback and identifies the three slowest tasks
7. Runs the playbook twice: once without pipelining and once with — report the wall-clock difference

> Tip: use `register` to capture all async job IDs into a list, then loop over them with `async_status`.
