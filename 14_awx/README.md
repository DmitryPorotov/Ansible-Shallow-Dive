
---

# Ansible AWX

<img src="../99_misc/.img/do.png" alt="awx" style="border-radius:25px;float:right;width:400px;">

---

AWX is the open-source upstream project behind **Red Hat Ansible Automation Platform** (formerly Ansible Tower). It provides a web UI, REST API, role-based access control, and a scheduler on top of Ansible — turning playbooks into a proper service that teams can share.

Topics covered:
- AWX vs Ansible Tower
- Architecture
- Installation with Docker Compose
- Key concepts: Organizations, Projects, Inventories, Credentials, Job Templates
- The AWX REST API
- Role-Based Access Control (RBAC)

---

# AWX vs Ansible Tower

| | AWX | Ansible Tower / AAP |
|-|-----|---------------------|
| License | Open source (Apache 2) | Commercial |
| Support | Community | Red Hat |
| Releases | Rolling (frequent) | Stable, long-term |
| Use case | Labs, small teams | Enterprise |

AWX is functionally identical to Tower. Skills learned in AWX transfer directly.

---

# Architecture

AWX is made of four components that run as containers:

```
┌───────────────────────────────────────────┐
│              Browser / API client          │
└────────────────────┬──────────────────────┘
                     │ HTTP/HTTPS
           ┌─────────▼──────────┐
           │    AWX Web (Django) │   ← serves UI & REST API
           └─────────┬──────────┘
                     │ task queue
           ┌─────────▼──────────┐
           │   AWX Task (celery) │  ← runs playbooks
           └─────────┬──────────┘
                     │
     ┌───────────────┼────────────────┐
     │               │                │
┌────▼───┐    ┌──────▼──────┐   ┌────▼─────┐
│Postgres│    │  Redis       │   │ receptor │
│  (db)  │    │ (msg broker) │   │ (comms)  │
└────────┘    └─────────────┘   └──────────┘
```

---

# Installation with Docker Compose

AWX can be run standalone for lab use. Install the AWX operator or use the official Docker Compose method.

**Quick start (requires Docker and Docker Compose):**

```sh
# Clone the AWX repo
git clone https://github.com/ansible/awx.git
cd awx

# Check out a stable release tag
git checkout tags/23.9.0

# Run the installer (uses Ansible itself)
pip install ansible
cd installer
ansible-playbook -i inventory install.yml
```

Or use the pre-built image directly:

```sh
docker run -d \
  --name awx_web \
  -p 8052:8052 \
  -e SECRET_KEY=awxsecret \
  ansible/awx:23.9.0
```

Default credentials: **admin / password** (change immediately).

---

# Key Concepts

AWX organises everything into a hierarchy:

```
Organization
 ├── Inventories   (which hosts)
 ├── Projects      (where playbooks live)
 ├── Credentials   (how to authenticate)
 ├── Job Templates (what to run + how)
 └── Users / Teams (who can do what)
```

---

# Organizations

An **Organization** is the top-level container. In a company you might have one per team or business unit.

Every other resource (inventory, project, credential, job template) belongs to an organization.

Create one from the UI: **Organizations → Add**

Or via the REST API:

```sh
curl -s -u admin:password \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"name": "Ops Team", "description": "Operations department"}' \
  http://localhost:8052/api/v2/organizations/
```

---

# Projects

A **Project** points AWX at a Git repository (or local path) that contains playbooks.

```
Settings → Projects → Add
  Name:         Ansible Course
  SCM Type:     Git
  SCM URL:      https://github.com/your-org/ansible-shallow-dive.git
  SCM Branch:   main
  Update on launch: ✓
```

AWX will pull the latest commit every time a job runs (if *Update on launch* is checked).

---

# Inventories

AWX inventories work exactly like Ansible inventory files — but stored in the database and editable from the UI.

**Static inventory via UI:**
```
Inventories → Add → Inventory
  Add Hosts:
    node1  (Variables: ansible_host=node1)
    node2  (Variables: ansible_host=node2)

  Add Groups:
    web → node1, node3
    db  → node2, node4
```

**Dynamic inventory via a source:**
```
Inventories → Add Source
  Source: Amazon EC2
  Region: eu-west-1
  Credential: (your AWS credential)
```

---

# Credentials

**Credentials** store secrets securely (encrypted at rest). AWX never shows the secret again after saving.

Types used in this course:

| Type | Used for |
|------|---------|
| Machine | SSH username + key to log into hosts |
| Source Control | Git deploy key or token |
| Vault | ansible-vault password |
| Amazon Web Services | AWS access key + secret |

Create a Machine credential:

```
Credentials → Add
  Name:            Lab SSH Key
  Credential Type: Machine
  Username:        docker
  SSH Private Key: (paste content of 99_misc/setup/docker/id_rsa)
```

---

# Job Templates

A **Job Template** ties together: playbook + inventory + credential + extra variables.

```
Templates → Add → Job Template
  Name:       Deploy Web
  Job Type:   Run
  Inventory:  Lab Inventory
  Project:    Ansible Course
  Playbook:   12_ansible_and_cloud/cloud_style_provision.yml
  Credentials: Lab SSH Key
```

Click **Launch** to run it. AWX shows live output and stores a full job history.

---

# Workflows

A **Workflow Job Template** chains multiple Job Templates with success/failure branching:

```
[Pre-flight checks]
       │
       ▼ (on success)
[Provision web tier] ── (on failure) ──▶ [Send alert]
       │
       ▼ (on success)
[Configure web tier]
       │
       ▼ (on success)
[Run smoke tests]
```

Create from: **Templates → Add → Workflow Job Template → Visualizer**

---

# Scheduling

AWX can run Job Templates on a cron schedule without any external tooling.

```
Templates → Deploy Web → Schedules → Add
  Name:       Nightly Deploy
  Start Date: 2025-01-01
  Time:       02:00 UTC
  Repeat:     Every 1 Day
```

The schedule stores in the AWX database and the task engine picks it up automatically.

---

# The REST API

Every action in the AWX UI is backed by a REST API. You can trigger jobs from CI/CD pipelines, scripts, or other tools.

**List job templates:**
```sh
curl -s -u admin:password \
  http://localhost:8052/api/v2/job_templates/ | python3 -m json.tool
```

**Launch a job template (id=5):**
```sh
curl -s -u admin:password \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"extra_vars": {"env": "staging"}}' \
  http://localhost:8052/api/v2/job_templates/5/launch/
```

**Poll job status:**
```sh
JOB_ID=42
curl -s -u admin:password \
  http://localhost:8052/api/v2/jobs/${JOB_ID}/ | python3 -m json.tool | grep status
```

---

# Practice — Exploring the API

The AWX API has a **browsable interface** at `http://localhost:8052/api/v2/`. Open it in a browser while logged in and explore the endpoints.

Key endpoints to explore:

| Endpoint | Purpose |
|----------|---------|
| `/api/v2/organizations/` | List/create orgs |
| `/api/v2/inventories/` | List/create inventories |
| `/api/v2/projects/` | List/create projects |
| `/api/v2/job_templates/` | List/create templates |
| `/api/v2/jobs/` | List job history |
| `/api/v2/me/` | Current user info |

```sh
# Try it:
curl -s -u admin:password http://localhost:8052/api/v2/me/ | python3 -m json.tool
```

---

# Role-Based Access Control (RBAC)

AWX lets you assign fine-grained permissions per resource:

| Role | Can do |
|------|--------|
| Admin | Everything |
| Execute | Launch job templates |
| Read | View only |
| Use | Use a credential / inventory in a template |

Assign via UI:

```
Organizations → Ops Team → Access → Add
  User:   alice
  Role:   Execute
```

Or via API:

```sh
curl -s -u admin:password \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"id": 3}' \
  http://localhost:8052/api/v2/job_templates/5/object_roles/execute/users/
```

---

# Practice — Full AWX Workflow

Using the lab project and the AWX instance:

1. Create an **Organization** called `Ansible Lab`
2. Create a **Project** pointing to your local clone (use SCM type `Manual`, path `/home/ansible/ansible_course`)
3. Create an **Inventory** with groups `web` and `db` and the lab nodes as hosts
4. Create a **Machine Credential** using the lab SSH key (`99_misc/setup/docker/id_rsa`)
5. Create a **Job Template** that runs `12_ansible_and_cloud/cloud_style_provision.yml`
6. **Launch** the job and watch the live output in the UI
7. Check the job history and inspect the stdout of the run

```sh
# Verify AWX is reachable from ansible-host inside the lab
curl -s http://awx:8052/api/v2/ | python3 -m json.tool
```

---

# Summary Exercise (no solution)

Design and implement a **multi-stage CI/CD pipeline in AWX** for the course lab:

1. Create a **Workflow Job Template** with the following stages (Job Templates):
   - **Stage 1 — Validate**: run `13_troubleshooting/diagnose.yml` against all nodes; fail the workflow if any assertion fails
   - **Stage 2 — Provision**: run the provision playbook from chapter 12 against web and db groups
   - **Stage 3 — Smoke test**: write and run a playbook that checks nginx responds on port 80 (web nodes) and postgresql is listening on port 5432 (db nodes)
   - **Stage 4 — Notify**: write a playbook that writes a deployment report to `/tmp/deploy_report.txt` on `ansible-host`

2. Add a **Schedule** that runs the workflow every night at 03:00 UTC

3. Create two AWX **Users**: `alice` (Execute on all templates) and `bob` (Read only). Verify via the API that `alice` can launch jobs but `bob` cannot.

4. Use the AWX REST API (not the UI) to trigger Stage 3 directly and poll until it completes.

> Hint: use the `/api/v2/workflow_job_templates/` and `/api/v2/workflow_jobs/` endpoints for the API part.
