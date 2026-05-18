
---

# Ansible Collections
<img src="../99_misc/.img/collections.png" alt="collections" style="border-radius:25px;float:right;width:400px;">

---

# Ansible Collections

Collections are a distribution format for Ansible content that can include playbooks, roles, modules, and plugins. You can install and use collections through a distribution server, such as Ansible Galaxy, or a Pulp 3 Galaxy server.

---

# Ansible Collections

As mentioned before, when your playbooks start growing for example, a playbook to install Nginx, another to configure users, another to set up monitoring, things get messy.
As such, Ansible introduced `roles`, a way to organize these tasks neatly.

Each role is like a mini-project that does one thing really well, as shown in previous chapter. `Roles` make your automation reusable and easier to share.

---

# So what Are “Collections”?

As people and teams started making lots of roles, plugins, and modules… Ansible needed a bigger box to package and share them together.

That’s where collections came in (starting from Ansible 2.9).

A collection is like a ZIP folder that can hold many roles, modules, and plugins under one name and version.

```sh

ansible_collections/
 └─ community/
     └─ general/
         ├─ roles/
         ├─ plugins/
         ├─ modules/
         └─ docs/
```

---
You can install it in one line:

```sh
ansible-galaxy collection install community.general
```

---

### Why Did We Get Here?

Originally, everything lived inside one giant Ansible repository.
But as it grew, updates became slower, and users wanted modularity and independence.
So the Ansible community split it into:
-  Core Ansible Engine
- Collections (the reusable knowledge packs )

Now, each collection can evolve faster, independently, and even be published by different vendors (like AWS, Cisco, or Red Hat).