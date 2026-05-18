# Ansible Shallow Dive



.footer: Created By Alex M. Schapelle VAioLabs.io, Otomato.io

<!--
 # Created By: Silent-Mobius Aka Alex M. Schapelle
# Purpose: being lazy on new course setup
# Copyright (C) 2023  Alex M. Schapelle

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 -->
---

# About The Course Itself ?

We'll learn several topics mainly focused on:

- What is Ansible ?
- Who needs AnsibleS ?
- How Ansible works ?
- How to manage Ansible in various scenarios ?


---

# Who Is This Course For ?

- The name kind of mentions it:
    - System administrators who wish to learn basic Ansible usage.
    - SysOps who are moving to DevOps jobs.
    - DevOps who wish to implement infrastructure as a code (IaC) with declarative language.
- But it also can be useful for:
    - Junior DevOps who wish to gain minimal knowledge of IaC.
    - Junior software developers who have no knowledge of IaC.

---

# Course Prerequisite

- TCP/IP knowledge - MUST
- UNIX/Linux shell usage - MUST
- Mild knowledge of shell scripting
- Moderate understanding of version control (git/github/gitlab) - Recommended
- Low-headed familiarity with containers (docker)

---

# Course Topics

- [Setup](../01_setup/README.md)
- [Fundamentals](../02_fundamentals/README.md)
- [Yaml Basics](../03_yaml_basics/README.md)
- [Playbooks](../04_playbooks/README.md)
- [Advance Execution](../05_advance_execution/README.md)
- [Roles](../06_roles/README.md)
- [Troubleshooting](../07_troubleshooting/README.md)

---

# About Me

<img src="../99_misc/.img/me.jpg" alt="drawing" style="border-radius:25px;float:right;width:180px;">

- Over 15 years of IT industry Experience.
- Fell in love with AS-400 unix system at IDF.
- 5 times tried to finish degree in computer science field
    - Between each semester, I tried to take IT course at various places.
        -  A+.
        -  Cisco CCNA.
        -  RedHat RHCSA.
        -  LPIC1 and Shell scripting.
        -  Other stuff I've learned alone.

---

# About Me (cont.)

- Over 7 years of sysadmin and system automation:
    - Shell scripting fanatic
    - Python developer
    - JS admirer
    - Golang fallen
    - Rust fan
- 8 years of working with devops
    - Git supporter
    - Vagrant enthusiast
    - Ansible consultant
    - Container believer
    - K8s user

---

# About Me (cont.)

You can find me on the internet in bunch of places:

- Linkedin: [Alex M. Schapelle](https://www.linkedin.com/in/alex-schapelle)
- Gitlab: [Silent-Mobius](https://gitlab.com/silent-mobius)
- Github: [Zero-Pytagoras](https://github.com/zero-pytagoras)
- ASchapelle: [My Site](https://aschapelle.com)
- VaioLabs-IO: [My company site](https://vaiolabs.io)


---

# About You

Share some things about yourself:

- Name and surname
- Job description
- What type of education do you poses ? formal/informal/self-taught/university/cert-course
- Do you know any of those technologies below ? What level ?
    - Docker / Docker-Compose / K8s
    - Jenkins
    - Git / GitLab / Github / Gitea / Bitbucket
    - Bash/PowerShell Script
    - Python3 / Pytest / Pylint / Flask
    - Go / Gin / Echo
    - Ansible / Terraform
- Do you have any hobbies ?
- Do you pledge your alliance to [Emperor of Man kind](https://warhammer40k.fandom.com/wiki/Emperor_of_Mankind) ?

---

# History


<img src="../99_misc/.img/pc-history.png" alt="pc history" style="border-radius:25px;float:right;width:300px;">

Many developers and system administrators manage servers by logging into them via SSH, making changes, and logging off. Some of these changes would be documented, some would not. If an admin needed to make the same change to many servers, the admin would manually log into each server and repeatedly make this change.

Some admins may use shell scripts to try to reach some level of sanity, but I’ve yet to see a complex shell script that handles all edge cases correctly while synchronizing multiple servers’ configuration and deploying new code

But there’s a reason why many developers and sysadmins stick to shell scripting and command-line configuration: it’s simple and easy-to-use, and they’ve had years of experience using bash and command-line tools. Why throw all that out the window and learn a new configuration language and methodology?

---

# History (cont.)

#### Enter Ansible

<img src="../99_misc/.img/ansible_logo.png" alt="ansible_logo" style="border-radius:25px;float:right;width:180px;">

The term "Ansible" was coined by Ursula K. Le Guin in her 1966 novel Rocannon's World, and refers to fictional **instantaneous communication systems**.

The Ansible tool was developed by [Michael DeHaan](https://www.linkedin.com/in/michaeldehaan/), the author of the provisioning server application Cobbler and co-author of the Fedora Unified Network Controller (Func) framework for remote administration.

Ansible, Inc. (originally AnsibleWorks, Inc.) was the company founded in 2013 by Michael DeHaan, Timothy Gerla, and Saïd Ziouani to commercially support and sponsor Ansible. Red Hat acquired Ansible in October 2015.

Ansible is included as part of the Fedora distribution of Linux, owned by Red Hat, and is also available for Red Hat Enterprise Linux, CentOS, openSUSE, SUSE Linux Enterprise, Debian, Ubuntu, Scientific Linux, and Oracle Linux via Extra Packages for Enterprise Linux (EPEL), as well as for other operating systems

As we can see, Ansible was built by developers and sysadmins who know the command line—and want to make a tool that helps them manage their servers exactly the same as they have in the past, but in a repeatable and centrally managed way. Ansible also has other tricks up its sleeve, making it a true Swiss Army knife for people involved in DevOps.


---

# What Is Ansible?

Ansible is multitude of tools, modules, and software defined Infrastructure, that are collectively ansible tool set.
For me and majority of other users, Ansible is an open-source software provisioning, configuration management, and application-deployment tool enabling infrastructure as code.
You are welcome to use either of those definitions.

#### Why We Need It?

Lets assume that you have a couple of remote instances running some services. Due to some issue or upgrade in those services you might need to alter the configurations in those remote instances. What you would have to do is make those changes in each of those instances manually. The importance of a configuration management system comes in handy in a situation like this. Do the configuration changes in a master instance and it will make sure that all other instances would have the proper changes. Ansible is a such configuration management tool. Ansible connects with its other instances using SSH. Therefore there is no concept such as an agent when using Ansible

---

# Ansible (cont.)

#### Do We Still Need  Bash/Python/Ruby/Go Scripts, Then ?

<img src="../99_misc/.img/yesbutno.png" alt="yesbutno" style="border-radius:25px;float:right;width:400px;">

<img src="../99_misc/.img/logos.png" alt="logos" style="border-radius:25px;float:right;width:600px;">

Let's discuss:

- Code development process
- Declarative Vs. Scripted
- Code maintenance
- Complexity management

---

# What Are Ansible's Prerequisites ?

Ansible requires Python to be installed on all `managed` machines, including `pip` package manager along with configuration-management software and its dependent packages. 
Managed network devices require no extra dependencies and are agent less. We can sum it up with:
- Ssh server
- Python3, with pip3

> `[!]` Note: essentially any minimal  UNIX/Linux machine should be managed with Ansible. In cases where python and other required packages are not found, Ansible can adapt,e.g Ansible manages windows machines with `Win-RM` and powershell.

### How Ansible Works ?

<img src="../99_misc/.img/gear.png" alt="gear" style="border-radius:25px;float:right;width:300px;">

Ansible uses combination of _inventories_, _executable_, _modules_, _yaml playbooks_ and _playbook roles_.


#### Inventories And Inventory File

- The inventory is a description of the nodes that can be accessed by Ansible. 
- `INI` or `YAML` are used as a default configuration format, while default configuration file is either located at `/etc/ansible/hosts` or under the users home directory. Depends on type of installation. 
- The configuration file lists either the IP address or hostname of each node that is accessible by Ansible. In addition, nodes can be assigned to groups

---

# How Ansible Works ? (cont.)

#### Ansible Modules

- Modules are mostly standalone and can be written in a standard scripting language (such as Python, Perl, Ruby, Bash, etc.). 
- One of the guiding properties of modules is idempotence, which means that even if an operation is repeated multiple times (e.g., upon recovery from an outage), it will always place the system into the same state

#### Ansible Playbooks

- Playbooks are YAML files that express configurations, deployment, and orchestration in Ansible, and allow Ansible to perform operations on managed nodes. 
- Each Playbook maps a group of hosts to a set of roles. Each role is represented by calls to Ansible tasks

#### Ansible Roles

- Each Playbook maps a group of hosts to a set of roles. Each role is represented by calls to Ansible tasks.


---

# Ansible Environment Setup

<img src="../99_misc/.img/setup.png" alt="setup" style="float:left;width:300px;">

.footer: Created By Alex M. Schapelle, VAioLabs.io

---

# Ansible Environment Setup 


As mentioned, we will be working on our virtual labs with `docker` and `docker-compose`, thus docker installation is required.
- What do we need ?
  - Unix/Linux Node
  - Docker environment installed
  - Text editor: I'll be using `vim`, yet your are welcome to use anything you wish and are comfortable with.

- To install `docker` and `docker compose` run on most well known (Debian,Ubuntu,Fedora,Rocky,Arch,Gentoo...) Linux distributions we will use the next command: 

```sh
curl -L get.docker.com| sudo bash
# it is good practice to add your user to docker group 
# to verify that there won't be any permission issues
sudo usermod -aG docker ${USER}
# although the permissions are given, they are not loaded 
# till new session is at hand, so we reload the session
sudo su ${USER}
```
  - In case you are using RedHat based Linux distro, like Fedora, Rocky and Alma, the above command should work in same manner.
  - With RedHat itself, it will require you to use license which you need to purchase
  - While with Windows, Please install Docker-Desktop.
  - In case of MacOS, Docker-Desktop is the solution at the moment, yet it changes rapidly, thus do ask instructor on the matter.

> `[!]` Notes: 
> I, myself am using Linux distribution, in case you use something else, there should not be too much of the difference, yet that is the price of learning: adaptation to the unknown.
>  You should try to use docker project from the course repository under folder named `99_misc/setup/docker` or from [gitlab repository here](https://gitlab.com/silent-mobius/ansible-compose.git)

---

# Ansible Environment Setup (cont.)

From here on we'll be using docker as a base of our virtual environment to test `ansible` command, configuration files, modules and so on.
In case you still do NOT have the gitlab repository mentioned above in note, and you do NOT have repository of this pdf as well, then you should try to get the project from [gitlab repository here](https://gitlab.com/silent-mobius/ansible-compose.git). In any other case, please follow the instructions below.

<img src="../99_misc/.img/do.png" alt="ansible_logo" style="border-radius:25px;float:right;width:250px;">

#### The Playground

The lab itself consist of `ansible-host` container, where we will be practicing, running, testing and validating our ansible configurations. All the code management, version control and code will be done on this very container, and the files saved will be outputted on your pc/laptop/environment under folder `99_misc/setup/docker/ansible`.
Additionally we will have four more containers, of `debian` and `rockylinux`, that will appear as vm's or remotely connected web/database/application servers, as you have in most of the environments in different organizations.
The main idea behind this containerized playground is to provide as with practice environment that is able to look like deployment platform, for us to practice and implement various parts of `ansible`.
The playground is reproducible so you may practice on your own when even you wish.

----

# Ansible Environment Setup (cont.)

#### Are There Any Other Places To Practice `ansible` ?

Yes - As mentioned, `ansible` was purchased by RedHat in 2015 and they can provide you with practice labs for their certifications, as well as other companies and self-employed instructors that teach the same course, via udemy, kodekloud, katakode, diveinto and so on ...

The main goal it to practice, and although theories are fine, but with no hands-on practice, in most of the cases, theories fly away like birds in winter...


---

# Staring The Lab

Back to the topic of setting up the local lab based on `docker` and `docker compose`. Here are initial step required to start the lab with some explanations :

- In case you do not have the required project files, clone the [repo](https://gitlab.com/silent-mobius/ansible-compose.git) to your working directory.
    - If you have the pdf project with you, then skip this step
- Move into project directory
    - If you have pdf project move into `99_misc/setup/docker`
- Initialize `docker compose` to start the process of building the lab
    - By the end you should have 5 running containers with ansible-host and nodes 1-4 up and running.

---

# Staring The Lab (cont.)

- Last  but not least, we log into `ansible-host` to start our learning process
    - We will be logged inside `ansible-host container`, with user named `ansible`, and most of tools already provided in there

```sh
sudo apt update && sudo apt install git -y

git clone https://gitlab.com/vaiolabs-io/ansible-shallow-dive.git

curl -L get.docker.com | sudo bash 

sudo usermod -aG docker admin

sudo su - admin

docker version

cd ansible-shallow-dive/99_misc/setup/docker/

docker compose up -d
```

---

# How Ansible Works

#### Architecture  Description

The design goals of Ansible include:

- __Minimal in nature__: Management systems should not impose additional dependencies on the environment.
    - That said if you are implementing Ansible from the beginning, it requires ssh/ssh-keys
- __Consistent__: With Ansible one should be able to create consistent environments.
- __Secure__: Ansible does not deploy agents to nodes. Only OpenSSH and Python are required on the managed nodes.
- __Reliable__: When carefully written, an Ansible playbook can be idempotent, to prevent unexpected side-effects on the managed systems. It is possible to write playbooks that are not idempotent.
- __Minimal learning required__: Playbooks use an easy and descriptive language based on YAML and Jinja templates.

---

# Architecture  Description (cont.)

Generally the Ansible architecture should be structures in a manner of remote machine or container that takes your ansible command/script/playbooks/roles/templates/anything IaC related, and with remote connection executes the task it was requested to do. Usually one illustration is far better then thousand words, thus lets have a look:

<img src="../99_misc/.img/ansible_arch.png" alt="our class arch" style="border-radius:25px;float:right;width:500px;">

To describe in bullet points:

- There are several server/computers/vms/containers/anything with ssh connections available.
- There is an `ansible host`:
    - `ansible` is invoked with manual trigger,either with `ansible` command or `ansible-playbook` 
        - Remote applications are also capable to invoke it (CI/CD tools)
    - `ansible` will read the inventory provided or will get inventory dynamically
    - `ansible` should start running the tasks it was requested to run

---

# Architecture  Description (cont.)

But in order to make it work, we'll need existing software packages, modules and configuration files to work on.
When we issue `ansible --version` command it will provide us with information about ansible referencing the configuration files.

```sh
ansible --version
ansible [core 2.14.3]
  config file = None
  configured module search path = ['/home/aschapelle/.ansible/plugins/modules',\
                                    '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/aschapelle/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.11.2
```
> `[!]` Note: `config file = None` that is reference to main ansible configuration is set to `None`, thus it gives us possibility to learn to build the file from scratch.

---

# Ansible Configuration File

We initially suggested that there are no default config files with Ansible, yet Ansible still requires to have one. Ansible seeks that file in various places with multiple locations based on the installation method, and the search has precedence within our working system.
The locations ansible will search for config file from the highest to lowest precedence are:
<!-- Show example from 4 to 1 -->
1. `ANSIBLE_CONFIG`: Environment variable with filename 
2. `./ansible.cfg`: An Ansible config file in current directory
3. `~/.ansible.cfg`: Hidden file in your users home directory.
4. `/etc/ansible/ansible.cfg`: Typically provided, through package manager of our system.

- This course works on files as if they were `Infra-As-a-Code` or `IaC`, thus the most usable way for us to use `git` with Ansible config file would be option 2.
- Ansible seeks for default config file in your shells current location
  - That's why we'll need to create local config file named `ansible.cfg`
- If Ansible won't find the local `ansible.cfg` file , it will not work so,


---

# Practice

- Create `/etc/ansible/` folder and int add `ansible.cfg`
- Run `ansible --version` and check `config_file` value
- Create `~/.ansible.cfg` 
- Run `ansible --version` and check `config_file` value
- Create folder test, `cd` into it and create `ansible.cfg`
- Run `ansible --version` and check `config_file` value
- Run `ANSIBLE_CONFIG=/tmp/ansible.cfg ansible --version` and check `config_file` value

---

# Inventories


<img src="../99_misc/.img/inventory.png" alt="our class arch" style="border-radius:25px;float:right;width:400px;">

Lets take a look on inventories, their types and uses on different types of Linux hosts, inventory variables, ranges, groups and group children 
However, before diving into these, One thing we must always consider. to work with our tools at hand: As mentioned, Ansible has several configuration files, and all these need to be maintained, updates, developed and saved on remote place.
In this course we'll be using `git` version control and `gitlab` remote server to work on the contents of Ansible files. As such the student working on their own device, will need to install git client on their working device and also create/use `gitlab/github/any remote git based repository` to follow the course.

---

# Inventories (cont.)

In order to start, well work in structured manner, of creating designated folders with chapter naming and under each chapter we'll practice subject at hand.
This chapter follows `setup` topic thus we should create folder named in the same manner in continue by using sub-folder for each sub-topic.E.g.

```sh
$ mkdir -p 01_setup/01_inventories
$ cd 01_inventories
$ touch ansible.cfg
$ ansible --version
    ansible [core 2.14.3]
    # required for ansible configuration
        config file = /home/aschapelle/00_ansible_cfg/ansible.cfg 
        configured module search path = \
            ['/home/aschapelle/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
        ansible python module location = /usr/lib/python3/dist-packages/ansible
        ansible collection location = \
            /home/aschapelle/.ansible/collections:/usr/share/ansible/collections
        executable location = /usr/bin/ansible
        python version = 3.11.2 (main, Mar 13 2023, 12:18:29) [GCC 12.2.0] (/usr/bin/python3)

$ echo '[defaults]' >> ansible.cfg
$ echo 'inventory=./hosts.ini' >> ansible.cfg
$ ansible --version
```

---

# Inventories (cont.)

### Static Inventories

Inventory file and its structure is crucial for Ansible. You can create your inventory file in one of many formats, depending on the inventory plugins you have. The most common formats are `INI` or `YAML`

- Inventory file is suggested either with `-i` option or with `ansible.cfg` configuration line specifying the location of the file.
    - Usually looks like this: `inventory = my_inv_file` or any other name
- An `.ini` file is a configuration file for computer software that consists of a text-based content with a structure and syntax comprising **key–value** pairs for properties, and sections that organize the properties
    - You can read about [`ini` in the link](https://en.wikipedia.org/wiki/INI_file), but it is pretty self explanatory, thus do not dwell on it too much.
- The inventory file can also be written in `yaml` format, with `.yml` extension, yet it is not mandatory.

---


# Inventories (cont.)

### Static Inventories

The structure can be provided as follows:

- defaults :Even if you do not define any groups in your inventory file, Ansible creates two default groups:
    - `[all]` : group contains every host
    - `[ungrouped]` : all hosts that don’t have another group aside from all

> `[!]` Note: Every host will always belong to at least 2 groups: `all` and `ungrouped` or `all` and some other group

- `[groups]`: Any name in square brackets is considered as custom group
    - Any hostname or ip address, under group name will be considered as part of a group
    - Each host can be in several groups at the same time.
    - Groups can have parent/child relationships.Parent groups are also known as nested groups or groups of groups.
        - To create parent/child relationships for groups in INI format, use the `:children` suffix

---

# What Now ?

- We'll setup our configuration and local inventory files that will manage our nodes
    - In virtual labs, there is no need to install Ansible, because it is installed already
    - We can install Ansible from `pip3` to use the latest version.
        - In python3.11 `pipx` is the tool required to do so and it also requires virtual-environments either with `venv`, `pipenv` or `poetry`
- Also we'll connect to all virtual nodes (containers)
- In addition, we will create version control to  manage our changes
- Finally we'll start using Ansible command line utility to learn its capabilities

In other words: lets go and practice

---

# Practice

- **Before starting the lab verify that you have empty repository for version control on gitlab or github. I recommend the first, yet you are free to use which ever you want to, as long as you will be able to debug your own issues that are not part of the course scope**
    - Suggested name for repository: `Ansible-Shallow-Dive`
- Log in to Ansible host container with : 
    - `docker compose exec -it ansible-host /bin/bash`
    - You'll be logged as user `ansible`, some what production level environment setup, which we will discuss later on.
- Verify that ansible is installed
- Create automation folder `01_ansible_inventory`
- Generate empty `ansible.cfg` `hosts.ini` `README.md` and `.gitignore` files
- Setup version control and save it to remote repository
- Edit gitignore not to save `*.swp` files
- Edit `ansible.cfg` with the text `[defaults]` and under it `inventory=hosts.ini`: we'll explain it later
- Edit `hosts.ini` file
  - Write down all the hosts names line by line from `node1` to `node4`
  - Issue an `ansible --list-host all`
    - If there is suitable output of all the nodes, You are done, else, check with the instructor


---

# Practice (cont.)

```sh
# Just in case you have not logged into ansible-host container
docker compose exec -it ansible-host /bin/bash
which ansible
ansible --version
mkdir 01_ansible_inventory && cd 01_ansible_inventory
touch README.md .gitignore ansible.cfg hosts.ini
git init 
git config user.name silent-mobius
git config user.mail alex@vaiolabs.com
echo '*.swp' > .gitignore
git add .
git commit -m "initial commit to repo"
git remote add {YOUR_REMOTE_GITLAB_REPO_WHICH_YOU_SHOULD_HAVE_CREATED}
git push -U origin master

```
---

# Practice (cont.)

```sh
vi ansible.cfg
    [defaults]
    inventory = hosts.ini
```

```sh
vi hosts.init
    node1
    node2
    node3
    node4
```

```sh
git add *
git commit -m "saving initial changes"
git push
ansible --list-hosts all
```


---

# Hosts and Groups Variables

The `hosts.ini` file enables us to create structured **key value** pairs, that eventually will be targets onto which we would execute remote commands.
In previous practice we did setup up groups but did not emphasized the explanations, thus lets address that:
Lets go back to the lab in docker-compose and edit additional configurations that we'll need.
```sh
# in case you did not login
docker compose exec -it ansible-host /bin/bash 
cd 01_ansible_inventory
```

We already have initial building blocks, in shape of `ansible.cfg` and `hosts.ini` files, so all we need is to update files as we learn more and more. In order to keep the files in an usable manner, I suggest to use git branches and keep each chapter outline and practice in different branches. Before we start updating config files, let us start by testing connectivity with the nodes:

- Lets check connectivity between `ansible-host` and nodes 1 to 4. 
    - Keep in mind that dns resolution is provided by `docker-compose`, so at the moment, there is no need to know IP addresses.
```sh
ping -c 1 node1
ping -c 1 node2
ping -c 1 node3
ping -c 1 node4
```
- Now, let's configure default inventory file inside our `ansible.cfg` config file and use to test same connection: 
- Notice that we have created `ansible.cfg` and added `defaults` entry, which provides default configuration to ansible to feed on.
- First configuration under defaults is location of `inventory` file, that can be a file with absolute or relative paths.

```sh
vi ansible.cfg
    [defaults]
    inventory = hosts.ini
```
- In previous practice, we wrote our nodes addresses by their hostnames in `hosts.ini` file.
    - As mentioned, by default all the nodes that are not written to any group are part of `group [all]`
- When running systems it is good idea to separate them in to logical groups, so we should regroup the content in `hosts.ini`
  
```sh
vi hosts.ini
    [web]
    node2
    node4
    [db]
    node1
    node3
    [multi:children]
    web
    db
```
> `[!]` Note: for purposes of the exercise these nodes do not exists. We are just providing examples of possible environments.

---

# Hosts and Groups Variables (cont.)
 
Lets check what we have:

```sh
ansible --list-hosts web
ansible --list-hosts db
ansible --list-hosts all
```
---

# Hosts, Groups and Variables (cont.)

When using Ansible, it will try to connect via ssh service, which in return requires digital fingerprint writing to `known_hosts` as well as ssh certificates, private and public.
The issue with digital fingerprints, are that in some cases we just want to check connectivity and to by pass that we can use custom Ansible environment variables as in any other UNIX/Linux command.

```sh
ANSIBLE_HOST_KEY_CHECKING=False  ansible  all -m ping
```

While it is somewhat convenient to use environment variables, it is always useful to set these setting in to configuration files. In this case almost all environment variables can be set into `ansible.cfg` file. 

```sh
vi ansible.cfg
```
```ini
[defaults]
inventory = hosts.ini
host_key_checking = False
```

---

# Hosts, Groups and Variables (cont.)

Each host in the `ini` file can have itself configured with Ansible variables for different purposes:
- `ansible_user`: The user name to use when connecting to the host
- `ansible_host`: The name of the host to connect to, if different from the alias you wish to give to it.
- `ansible_password`: The password to use to authenticate to the host (never store this variable in plain text)
- `ansible_ssh_private_key_file`: Private key file used by ssh. Useful if using multiple keys and you don’t want to use SSH agent
- `ansible_become`: Equivalent to `ansible_sudo` or `ansible_su`, allows to force privilege escalation
- `ansible_become_method`: Allows to set privilege escalation method
- `ansible_become_password`: Equivalent to ansible_sudo_password or ansible_su_password, allows you to set the privilege escalation password

Are there more variables? yes, definitely but, we'll NOT gonna cover it all.

```sh
vi hosts.ini
```
```ini
[all]
node1 ansible_user=user ansible_password=docker
```

---

# Hosts, Groups and Variables (cont.)

Let's test our configuration with modules. We'll cover them later in depth, but for now let's use `ping` and `command` modules.
```sh
ansible all -m ping -o
ansible all -m command -a 'id' -o
```
When using `ping` module, we should get json output, with value `pong`. If no value comes or there are errors, it means something is wrong and we must fix it.
When using `command`, we are asking Ansible to run a `specific command` on remote hosts. The `specific command` is passed as an argument to `command` module. If we get output of the command passed as an argument, then it worked, yet if we did not get the command output, we need to fix the configuration.

---

# Practice

- Add to existing node1 and node3 user `root` and password `docker`
- Test connection with command `id` and verify that user providing the answer is `root`

```ini
[db]
node1   ansible_user=root   ansible_password=docker
node3   ansible_user=root   ansible_password=docker
```
```sh
ansible all -m command -a 'id' -o
```
---

# Hosts, Groups and Variables (cont.)

As seen in our first example, we can chain groups of hosts and also we can chain group of groups as `children` groups. In previous we saw that we can add to each host its own Ansible variable, but one must agree that there should be better way to do so, we can setup group variables.

```ini
[multi:children]
web
db

[multi:vars]
ansible_user = root
ansible_password = docker
```
---

# Practice

- Remove db group nodes variables
- Add to existing inventory multi-group variables of `ansible_user` and `ansible_ssh_private_key`
- Test the variables with `id` command.
    - If there are any errors, act accordingly to fix them.

```ini
[multi:vars]
ansible_user = root
ansible_ssh_private_key_file = ./id_rsa
```

```sh
chmod 600 id_rsa
ansible all -m command -a 'id' -o
```


---

# Dynamic Inventories

Mostly can be implemented where there is API for managing vm's
- Cloud
- Virtual environment

Why do we need `Dynamic Inventory`, if you already have `Static Inventory` ?

#### And

If `Dynamic Inventory` exists , What's the point in having `Static Inventory` ?

Dynamic inventories are implemented mainly in environments where 3rd party application can `feed` Ansible with data regarding to hosts on the network. Most of these are `cloud` environments, yet there are custom made applications with `api`, such as cobbler, openstack and so on, that can serve as host inventory provider in closed networks. One may find an [example](https://github.com/lukaspustina/dynamic-inventory-for-ansible-with-openstack/blob/master/openstack_inventory.py) here. 

Also we can find [official documentation](https://docs.ansible.com/ansible/latest/dev_guide/developing_inventory.html) helping developing scripts , mostly python based, for dynamic inventory generation.

  <!-- - test connection with `ping` module to verify the connection -->

> `[!]` Note: We'll talk about Dynamic inventories later during the course.



--- 

# Ansible Ad-Hoc Commands

.footer: Created By Alex M. Schapelle, VAioLabs.io

---

# Ansible Ad-Hoc Commands

Let us explore how Ansible helps you quickly perform common tasks on, and gather data from, one or many servers with **ad-hoc** commands. The number of servers managed by an individual administrator has risen dramatically in the past decade, especially as virtualization and growing cloud application usage has become standard fare. As a result, admins have had to find new ways of
managing servers in a streamlined fashion.
On any given day, a systems administrator has many tasks:

- Apply patches and updates via dnf, apt, and other package managers.
- Monitor resource usage (disk space, memory, CPU, swap space, network).
- Manage system users and groups.
- Deploy applications or run application maintenance.
- And so on ...

Ansible allows admins to run ad-hoc commands on one or hundreds of machines at the same time, using the `ansible` command.


---


# Ansible command

```sh
ansible <HOST> -b -m <MODULE> -a "<ARG1 ARG2 ARG_N>" -f <NUM_FORKS>
```
- `-b`: request for Ansible to become root user on remote host
- `-m`: ask Ansible to use specific module (as mentioned the default is `command`)
- `-a`: pass a argument to module
- `-f`: run Ansible in parallel with all
- `-i`: use specific inventory and not the default.
- `-e`: pass extra variable of your choice

We run Ansible executable according to its commands parameters with `inventory` file hosts. Ansible runs ad-hoc commands

- Ad-Hoc commands are basic commands used by Ansible
- `Commands` essentially are _python written code_ to behave as simple system call.
- By default, if no Ansible command/module is provided, it will run with `command` ad-hoc module
- `Command` module is NOT processed with shell, so environment variables and shell operators such as <,>,;,|,& will not work
    - For Windows, `win_command` module is required, and by default `ansible` will fail if `command` is used.
- [Please see the docs](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/command_module.html)

---

# Practice

- Connect to remote host with user `docker` and become root user with sudo
- Use module named `command` to see the output of `/etc/os-release` file on all hosts

```ini
[multi:var]
username=docker
password=docker
```

```sh
ansible all -m command -a 'cat /etc/os-release' 
```
---

# Idempotence

An operation is idempotent, if the result of performing it once, is exactly the same as the result of performing it repeatedly without any intervening actions.
As such when we use `ansible` , it tries to notify as if the action we performed was idempotent or not, by coloring the output with 3 rather intuitive colors:

- `Green` : Success, no changes have been done.
- <span style="background:yellow">Yellow</span> : Success, changes performed were successful.
- <span style="background:red">Red</span> : Failure

---

# Ansible Modules and Plugins

#### What is the difference ?

<img src="../99_misc/.img/modules.png" alt="our class arch" style="border-radius:25px;float:right;width:200px;">

- Plugins extend Ansible’s core functionality. Most plugin types execute on the control node within the `/usr/bin/ansible` process.
- Modules, are discrete units of code that can be used from the command line or in a playbook task. Ansible executes each module, usually on the remote target node, and collects return values. Modules are the main building blocks of Ansible playbooks. Although we do not generally speak of “module plugins”, a module is a type of plugin.
A lot of times Ansible is addressed as `batteries included framework`. and the reason is the vast list of modules that we can use.


- Here is a list of 100 most used modules: [check it out](https://mike42.me/blog/2019-01-the-top-100-ansible-modules)
  - No : We are not gonna learn them all.
  - Yes: We'll go through a lot of them.

> `[!]` Note: Ansible project has been disassembled due to its massive size and currently the modules that we are covering are called `builtin` modules.

> `[!]` Note: Additional modules can be found under official documentation: `https://docs.ansible.com` and also at ansible galaxy repository: `https://galaxy.ansible.com`


---

# Ansible Modules (cont.)

#### `Setup` Module
Let us begin with module named `setup`:

- Purpose: Collect Ansible fact
- Arguments: gather_subset=<SUBSET_GROUP\> filter=<FILTERED_VALUE\>
- This module is automatically executed, when playbooks are used, to gather info as variable, about remote targets
- It can be executed manually to find out variable on available hosts
    - Variables/information received are called `facts`
- `setup` is supported on all platforms with remote access (ssh/winrm)
- [Please see the docs](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/setup_module.html)

---

# Practice

- Create folder 02_fundamentals/modules/setup
- `cd` into it
- Ping node1 and node2
- Verify in inventory that nodes above are defined
- Use `setup` module to get facts from node1 and node2 one after another
- Try to filter out the node1/2 ip address with `filter` attribute
- Save the commands in cmd_line.txt file and back it up with git version control

```sh
mkdir -p 02_fundamentals/modules/setup && cd 02_fundamentals/modules/setup
ping -c 1 node1
ping -c 1 node2
ansible --list-host all
ansible node1 -m setup -a "filter=ansible_distribution"
ansible node2 -m setup -a "filter=ansible_distribution"
echo !!  >> cmd_line.txt

```

---

# Ansible Modules (cont.)

#### `File` Module
Sets attributes of files, symlink and directories, or removes them. Many other modules support the same options as the `file` module, including `copy`, `template` and `assemble`

- For Windows targets, use the `win_file` module instead 
- Ansible project changes has modified the `file module` to be classed as a builtin plugin, thus it and other modules can be invoked with:
    - `file`
    - `ansible.builtin.file`
- Module can be used with various `states`, meaning we can require it to perform most of the operations on files as we do on any *nix based system:
    - `absent`
    - `touch`
    - `directory`
    - `link`
    - `hard`
- Every action with `file` module can be accompanied with mode of permissions like in any other *nix system
- [Please see the docs](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/file_module.html)

---

# Practice

- Create folder 02_fundamentals/modules/File and move into it.
- Execute module file while creating file named `test` at `/tmp` path on all the nodes
- Use file module to create empty folder `config` at `/opt` folder
- Change the `test` file permission to be read and written by user only
- save all commands in to cmd_line.txt and save it on git version control

```sh
mkdir -p 02_fundamentals/modules/File && cd 02_fundamentals/modules/File
ansible all -m file -a 'path=/tmp/test state=touch'
ansible all -m file -a 'path=/opt/config state=directory'
ansible all -m file -a 'path=/tmp/test state=touch mode=600'

```

---

# `Copy` Module

- The `copy` module copies a file from the local or remote target, to a location on the remote target. The reverse action can be accomplished with `fetch` module.
    - from source to destination
- If we need to use it in scripting, it is suggested to use `template` module.
- For windows we use `win_copy` module instead
- Most of other options from `file` module are also applicable onto this module as well
- [Please see the docs](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/copy_module.html)



---

# Practice

- Create folder 02_fundamentals/modules/copy and move into it.
- Create a file named `conf_web.yaml` and write in it name of web server with the path to `index.html`.
    - In case of nginx -> `/usr/share/nginx/html/index.html`
- Use `copy` module to copy `conf_web.yaml` file to `/opt` on web servers
- Create a file named `conf_db.yaml`  and write in it name of db server with path to its configuration file
    - In case of postgresql15 -> `/etc/postgresql/15/main/postgresql.conf`
- Use `copy` module to copy `conf_db.yaml` file to `/opt` on web servers
    - Bonus: change the mode of the file to 000 while copying it
```sh
mkdir -p 02_fundamentals/modules/copy && cd 02_fundamentals/modules/copy
touch conf_web.yaml conf_db.yaml
echo 'nginx: /usr/share/nginx/html/index.html' > conf_web.yaml
echo 'postgresql15: /etc/postgresql/15/main/postgresql.conf' >conf_db.yaml
ansible web -m copy -a 'src=./conf_web.yaml dest=/opt/conf_web.yaml'
ansible db -m copy -a 'src=./conf_db.yaml dest=/opt/conf_db.yaml'
ansible db -m copy -a 'src=./conf_db.yaml dest=/opt/conf_db.yaml mode=000'
```
---

# Ansible modules (cont.)
As mentioned, learning all the modules and plugins, can be tiresome, and in some case pointless, due to long list of `builtin` modules and vast lists of Ansible-collections which  are essentially 3rd party modules for 
special uses cases, such as cloud access, platform access and so on. Thus here is a list of rest plugins that is suggested to go over and learn, yet still go on reading the documentation.

- [RTFM](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/)
- Module: ping
    - Purpose: Verify Ansible connectivity between hosts.
    - Arguments: None
- Module: debug
    - Purpose: Print statements during execution.
    - Arguments: msg=<THE_CUSTOM_MESSAGE\> var=<A_VAR_NAME_TO_DEBUG\>
- Module: apt
    - Purpose: Install software with apt.
    - Arguments: name=<PACKAGE_NAME\> state=<STATE\>

---

# Ansible modules (cont.)

- Module: dnf/yum
    - Purpose: Install software with apt.
    - Arguments: name=<PACKAGE_NAME\> state=<STATE\>

- Module: get_url
    - Purpose: Downloads files from HTTP, HTTPS, or FTP to the remote server
    - Arguments: url=<URL\> dest=<PATH\>
- Module: lineinfile
    - Purpose: Ensures a particular line is in a file, or replace an existing line using a back-referenced regular expression
    - Arguments: path=<PATH\> line=<LINE_TO_ADD\> regex=<REGEX_TO_MATCH\>
- Module: archives
    - Purpose: Creates or extends an archive
    - Arguments: path=<PATH\> dest=<PATH\>
---

# Ansible modules (cont.)

- Module: user
    - Purpose: Manage user accounts and user attributes
    - Arguments:   name=<USERNAME\> comment=<DESCRIPTION\> uid=<UID\> group=<GROUPNAME\>
- Module: service
    - Purpose: Control service daemons.
    - Arguments: name=<SERVICE_NAME> state=<STATE\>
- Module: systemd
    - Purpose: Controls systemd units (services, timers, and so on) on remote hosts.
    - Arguments: name=<SERVICE\> state=<EXPECTED_STATUS\>
- Module: git
    - Purpose: Manage git checkouts of repositories to deploy files or software.
    - Arguments: repo:<GIT_REPO_URL\> dest:<PATH\>
---

#  Summary Practice

- Run Ansible command to with needed module to:
  - List all hosts in inventory file.
  - Ping web group in hosts list.
  - Get environment variables of all remote hosts.
  - Get package manager of all remote hosts.
  - Install: git, unrar, ssh-agent/sshpass, python3 and htop on all hosts. (on redhat based system ssh-agent is as same as sshpass)
  - Verify that user (user, vagrant or any other specific) exists in system.
  - Install web server on web group hosts.
  - Install db  server on db group hosts.
  - Check if web service is running on web host group.(apache2 or nginx)
  - Check if db service is running on db host group.(mysql or postgresql)
  - Set kernel parameter of `net.ipv4.conf.all.accept_redirects` to 1 at /etc/sysctl.conf (it will need to be uncommented).
  - Check what is the storage capacity on all hosts.


---

# Ansible Playbooks


---

# Before we begin

Few things that we need to have general understanding:

- Python is interpreted dynamic programming language
- Any programming language utilizes data-types, variables, conditions, loops, data-structures, classes, objects and Python is not an exception
    - Unique feature of python is indentation
    - Due to YAML being developed  with Python, it inherits those treats
    - Python can read/write/pass data, mainly values from YAML to YAML 
- Ansible was developed with Python programming language
    - It also inherits Python features 
    - YET, to simplify it adds its own keyword implementation variables, conditions, loops, block, roles and modules
        - Yes - you can develop modules in Python
- For us to continue, we only need to remember that data-type mostly used with any programming language is string and integer.

---

# YAML: Yet Another Markup Language

Applications and software in general, moves information by sharing its own data with each other apps, in a type of a format that is predefined and acknowledge by all applications.
For example in web applications most beloved and used format is `json`. Although `json` syntax in many cases can be confusing, and hard to read.

#### YAML to the rescue

- YAML is as human readable, data-serialization language.
- Easy to use, easy to read and easy to collaborate with as well.
- Reading and writing of YAML format is support in most major programming languages
- YAML files are often described with `.yaml` or `.yml` extensions.
    - `.yaml` is the officially recommended extension since 2006, yet in case you work with *nix based system, it does not matter

---

# YAML: Yet Another Markup Language (cont.)

#### YAML to the rescue

- YAML consists of key/value pair collections also known as `dictionaries`
    - Keys need to be unique
    - Values can be the same
    - Keys and values are separated with colon (:)
        - Everything after colon is treated as _string_
        - In some cases, solely numbers are treated as _integers_
            - Unless they are between single or double quotes -> then they are _strings_
    - `dictionaries` or `dicts` for short, are storing data structures inside programming languages
        - When we indent in YAML - we start new `dict`
    - There are also `list`, which also stores data, yet it uses only values, without key
        - Usually there is a key that defines collection of list


---

# Examples

- [validate script](../03_playbooks/00_examples/validate.sh)
- [init](../03_playbooks/00_examples/00_init.yaml)
- [keys/values](../03_playbooks/00_examples/01_key_value.yaml)
- [keys/values with integers](../03_playbooks/00_examples/02_key_value_int.yaml)
- [keys/value with quotes](../03_playbooks/00_examples/03_key_value_quote.yaml)
- [key/value as multiline](../03_playbooks/00_examples/04_key_multi_line.yaml)
- [key/value as singleline](../03_playbooks/00_examples/05_key_multi_as_singleline.yaml)
- [keys/values with boolean](../03_playbooks/00_examples/06_key_with_bool_value.yaml)
- [values list ](../03_playbooks/00_examples/07_list_values.yaml)
- [invalid syntax](../03_playbooks/00_examples/08_invalid_example.yaml)
- [indented key with keys/values](../03_playbooks/00_examples/09_indented_key_with_keys_values.yaml)
- [key with list values](../03_playbooks/00_examples/10_key_with_list_value.yaml)
- [indent key with key list values](../03_playbooks/00_examples/11_indent_key_with_key_list_values.yaml)

---

# Practice

- Use test shell script in [Project](../03_playbooks/validation.sh) to validate YAML that we  will create.
- Create file called test.yaml with appropriate start and end markers, run the test script -> the output should be NONE
- Create a list of car manufacturers, it should include brands below, yet you are welcome to add:
    - Acura
    - Mazda
    - Honda
- Change each of these entries in the list, so they are dictionaries
- Add as key/values to each car manufacturers, when they were founded and what is their web-site
- Add a key of `founded_by`, but with a list of the founder or founders

---

# Practice (cont.)

```yaml
Acura:
  year_founded: 1986
  website: acura.com
  fonded_by:
    - Soichiro Honda 
Mazda:
  year_founded: 1920
  website: mazda.com
  fonded_by:
    - Jujiro Matsuda
Nissan:
  year_founded: 1933
  website: nissan-global.com
  fonded_by:
    - Masujiro Hashimoto

```

---

# How YAML is used with Ansible ?

As we saw from examples, YAML is a structured data, that is passed to ansible modules. Those modules pass it to predefined python scripts. these scripts are copied to target machines, and executed with the values passed from YAML

<img src="../99_misc/.img/ansible_how.png" alt="how ansible works" style="float:left;width:700px;">

---

# Ansible Playbook/YAML Structure

<img src="../99_misc/.img/dev-playbook.png" alt="devplaybook" style="border-radius:25px;float:right;width:200px;">

#### How ansible sees YAML

- Hosts: lists of target hosts that we'll run playbooks on
- Vars: variables that apply to the play on all target systems
- Tasks: list of tasks that will be executed  within play, including pre and post tasks
- Handlers: list of handlers (notification tasks) that are executed with `notify` keyword from `tasks`
- Roles: list of roles (dedicated tasks ) to be imported  into the play

---

# Ansible Playbook/YAML Structure (cont.)

In side the YAML it would look like this: 

```yaml
# Every YAML file should start with three dashes 
---

# The  minus in YAML this indicates a list item. the playbook contains a list of plays,
# with each play being a dictionary
-
  # Hosts: lists of target hosts that we'll run playbooks on
  # Vars: variables that apply to the play on all target systems
  # Tasks: list of tasks that will be executed  within play, including pre and post tasks
  # Handlers: list of handlers (notification tasks) that are executed with `notify` keyword from `tasks`
  # Roles: list of roles (dedicated tasks ) to be imported  into the play
  # Note: not all are required to be used in single playbook
# Every YAML file file should end with three dots
...
```

Each line would represent the configuration that we would use in combination of a module/s that we would use to execute.
> `[!]` Note: we'd also need to use our `ansible.cfg` and `hosts.ini` to make it work

---

# Ansible Playbook/YAML Structure (cont.)

#### Example of setup

```sh
mkdir -p 03_playbooks/00_init_setup
touch ansible.cfg hosts.ini motd_playbook.yaml db_motd

echo 'This is MOTD file for DB servers - Deployed by ansible' > db_motd

echo '[defaults]' > ansible.cfg
echo 'inventory=hosts.ini' >> ansible.cfg
```
Then we edit the motd_playbook.yaml
> `[!]` Note: `hosts.ini` file should be the same as we have set before, thus no point showing how to copy paste it.

---

# Ansible Playbook/YAML Structure (cont.)

#### Example of setup (cont.)

```yaml
---

# The  minus in YAML this indicates a list item. the playbook contains a list of plays,
# with each play being a dictionary
-
  # Hosts: lists of target hosts that we'll run playbooks on
  hosts: db
  user: root

  # Vars: variables that apply to the play on all target systems
  # Tasks: list of tasks that will be executed  within play, including pre and post tasks

  tasks:
    - name: Configure a MOTD (Message Of The Way) on DB server
      copy:
        src: db_motd
        dest: /etc/motd
  # Handlers: list of handlers (notification tasks) that are executed with `notify` keyword from `tasks`
  # Roles: list of roles (dedicated tasks ) to be imported  into the play
  # Note: not all are required to be used in single playbook
# Every YAML file file should end with three dots
...

```

To execute the playbook with `ansible-playbook` command with the name of playbook

```sh
ansible-playbook motd_playbook.yaml
```

---

# Practice

- Create folders 03_Playbooks/00_init and `cd` into it:
  - Setup `hosts` file and `ansible.cfg` files appropriately
  - Create initial playbook called **playbook-ping.yaml**
    - In playbooks create a task that pings all possible hosts
    - [RTFM](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/ping_module.html)
- Go back to 03_playbooks and create new folder 01_playbook_copy and `cd` into it:
    - Verify that you have `hosts` and `ansible.cfg`
    - Create file db_motd with message : `Welcome to DB server- deployed by ansible`
    - Create a playbook called **playbook-copy.yaml**
        - use user root to perform the task
        - Copy the db_motd file to `/etc/motd`  on all db targets
        - [RTFM](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/copy_module.html)

---

# Practice (cont.)

```yaml

---
- hosts: all
  tasks:
    - name: ping all nodes
      ping:

...
---
hosts: db
user: root
tasks:
  - name: Copy MOTD 
    copy:
      src: db_motd
      dest: /etc/motd
...
```
---

# Ansible Playbook/YAML Structure (cont.)

#### Variables use in playbooks

In some of the playbooks we;ll be able to configure and setup static values to be used during the playbook. This concepts is called `variable` use.
We create new section in out playbook called `vars` and under its indentation we add a _key_ word which is variable name and  with a _string value_ which is variable value.
Later on we can summon the value by using double curly braces with double quotes: `"{{ variable_name }}"`

Variable playbook example:

```yaml
---
-
  hosts: db
  user: root

  # Vars: variables that apply to the play on all target systems
  vars:
    motd: 'Welcome to DB server - Deployed By Ansible '
  tasks:
    - name: Configure a MOTD (Message Of The Way) on DB server
      copy:
        content: "{{ motd }}"
        dest: /etc/motd
```

---


# Ansible Playbook/YAML Structure (cont.)

#### Variables use in playbooks

One additional features with Variables in playbooks is that, they can also be passed externally with `-e` or `--extra-vars` option to `ansible-playbook` command 

```sh
ansible-playbook motd_playbook.yaml -e 'motd="This is a TEST motd output"'
```

---

# Practice

- Go back to 03_playbooks and create new folder 02_playbook_copy_vars and `cd` into it:
    - Verify that you have `hosts` and `ansible.cfg`
    - Copy **playbook-copy.yaml** to this folder and edit the **vars** section in playbook:
        - Add variable `motd` with value of `Welcome to DB server- deployed by ansible`
        - Verify that you are **NOT** copying the `db_motd` file
            - Inserted use `content` key in `copy` module and place `"{{ motd }}"` variable
        - Use user root to perform the task
        - Run playbook on all db targets
        - Test the MOTD on remote DB node that it has indeed changed
        - Pass extra variable to playbook with content of `This is TEST motd`
        - Test the MOTD on remote DB node.
        - [RTFM](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/copy_module.html)

---

# Practice (cont.)

```yaml
---
-
  hosts: db
  user: docker

  vars:
    motd: "Welcome to DB Server - Deployed by Ansible"
  tasks:
    - name: Configure a MOTD (Message Of The Way) on DB server
      copy:
        content: "{{ motd }}"
        dest: /etc/motd
      become: True
...
```

```sh
ansible-playbook motd_playbook.yaml
ansible-playbook motd_playbook.yaml -e 'motd="This is TEST motd"'
```
---


# Ansible Playbook/YAML Structure (cont.)

#### Expanding on target section

If have not noticed, when running with Ansible, each time a setup module, aka fact gathering task, is run automatically. It gets values from targets to be used later in playbook.
The setup module use in many cases adds over head which might not be useful in cases when remote ansible variables are not required.
Thus this can be configured either to filter the required values or to disable all at once.


```yaml
---
-
  hosts: db
  user: root
  gather_facts: False
  vars:
    motd: 'Welcome to DB server - Deployed By Ansible '
  tasks:
    - name: Configure a MOTD (Message Of The Way) on DB server
      copy:
        content: "{{ motd }}"
        dest: /etc/motd

```

---

# Ansible Playbook/YAML Structure (cont.)

#### Handlers

Sometimes you want a task to run only when a change is made on a machine. For example, you may want to restart a service if a task updates the configuration of that service, but not if the configuration is unchanged. Ansible uses handlers to address this use case. Handlers are tasks that only run when notified.

Tasks can instruct one or more handlers to execute using the `notify` keyword. Handlers must be named in order for tasks to be able to notify them using the notify keyword.

Alternatively, handlers can utilize the `listen` keyword. Using this handler keyword, handlers can `listen` on topics that can group multiple handlers.

```yaml
---
-
  hosts: db
  user: root
  gather_facts: False

  vars:
    motd: 'Welcome to DB server - Deployed By Ansible '
  tasks:
    - name: Configure a MOTD (Message Of The Way) on DB server
      copy:
        content: "{{ motd }}"
        dest: /etc/motd
      notify: Configure of MOTD  

  # Handlers: list of handlers (notification tasks) that are executed with `notify` keyword from `tasks`
  handlers:
    - name: Configure of MOTD 
      debug:
        msg: The MOTD was changed

```

---

# Practice 

- Go back to 03_playbooks and create new folder 03_playbook_copy_handlers and `cd` into it:
    - Verify that you have `hosts` and `ansible.cfg`
    - Create **playbook_copy_handlers.yaml** in this folder and add the **handlers** section in playbook:
        - Create task with file module that will remove the /etc/motd file from target hosts
        - Verify that you are not using fact gathering (aka setup module)
        - Add handler with debug module that provides output message when task succeeds
        - [RTFM](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/file_module.html)
---

# Practice (cont.)

```yaml

---
-
  hosts: db
  user: root
  gather_facts: False
  vars:
    motd: 'Welcome to DB server - Deployed By Ansible '
  tasks:
    - name: Remove MOTD file
      file:
        path: /etc/motd
        state: absent
      notify: Remove MOTD file

  handlers:
    - name: Remove MOTD file
      debug:
        msg: MOTD file was removed

```

---

# Ansible Playbook/YAML Structure (cont.)

#### Conditions

When we mentioned `setup` module, we explained that it gathers information about the remote targets. Following that, we can make decisions based on those information facts.
The simplest conditional statement applies to a single task. Create the task, then add a `when` statement that applies a test. The `when` clause is a raw Jinja2 expression without double curly braces

```yaml
---

-
  hosts: db
  user: root
  vars:
    motd_db: 'Welcome to DB server - Deployed By Ansible '
    motd_web: 'Welcome to Web server - Deployed By Ansible '
  tasks:
    - name: Configure a MOTD (Message Of The Way) on DB server
      copy:
        content: "{{ motd_db }}"
        dest: /etc/motd
      when: ansible_distribution == "Rocky"
      notify: Configure a MOTD

    - name: Configure a MOTD (Message Of The Way) on Web server
      copy:
        content: "{{ motd_web }}"
        dest: /etc/motd
      when: ansible_distribution == "Debian"
      notify: Configure a MOTD

  handlers:
    - name: Configure a MOTD
      debug:
        msg: The MOTD was changed

```
---

# Practice
- Go back to 03_playbooks and create new folder 04_playbook_copy_conditions and `cd` into it:
    - Verify that you have `hosts` and `ansible.cfg`
    - Create **playbook_copy_conditions.yaml** in this folder and:
        - Run task on all hosts
        - Create task with apt or dnf modules, depending on `ansible_distribution` fact, which will install nginx web server on web group or postgresql on db group
        - Verify that you ARE using fact gathering (aka setup module)
        - Add handlers with service module that restarts the service once it is installed
        - [RTFM apt ](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/apt_module.html)
        - [RTFM dnf ](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/dnf_module.html)
        - [RTFM service ](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/service_module.html)

---

# Practice (cont.)

```yaml
---
-
  hosts: all
  user: root

  tasks:
    - name: Configure a MOTD (Message Of The Way) on DB server
      dnf:
        name: postgresql15
        state: present
      when: ansible_distribution == "Rocky"
      notify: Restart db service

    - name: Configure a MOTD (Message Of The Way) on Web server
      apt:
        name: nginx
        state: present
      when: ansible_distribution == "Debian"
      notify: Restart web service

  handlers:
    - name: Restart db service
      service:
        name: postgresqld
        state: restarted
   
    - name: Restart web service 
      service:
        name: nginx
        state: restarted

...

```
---

# Summary Practice

- Create folder 05_summary_practice and `cd` into it
- Setup `ansible.cfg`. `hosts.ini`, `playbook.yaml`, or you can copy it from last practice
- Configure/update playbook.yaml to work only on all servers
- Create task that will use copy module to copy content with shell script that prints `hello world`
- Copy the content into /tmp/hello.sh script on all targets and give them execution permissions
- Create task with shell module that will execute the script remotely

---

# Ansible Advance Execution


---

# Extending view on variables

We'll go over examples of variables use and expand on the knowledge we just got from previous encounter.

- [simple use](../04_advance_playbooks/00_variables/00_simple.yaml)
- [dictionary variable](../04_advance_playbooks/00_variables/01_dict.yaml)
- [named_list](../04_advance_playbooks/00_variables/02_named_list.yaml)
- [variables in external variable file](../04_advance_playbooks/00_variables/03_extenal.yaml)
- [prompting user](../04_advance_playbooks/00_variables/04_prompt.yaml)
- [hostvar usage](../04_advance_playbooks/00_variables/05_hostvar_use.yaml)


---

# Practice

- Create folder vars
- Create in vars folder yaml file called  `details.yaml`
    - Set key value pairs of:
        - username with your username
        - list of songs/artist/books that you like
        - dictionary of your family members( your_family: you, wife, kids, girlfriend, parents: father, mother, siblings)
- Create playbook that includes vars in it and displays them with debug module

---

# Practice (cont.)

```sh
mkdir vars
touch vars/details.yaml
```

```yaml
username: silent-mobius
other_username: zero-pytagoras
list_of_songs:
    - "livin la vida loca"
    - "no scrubs"
    - "black magic woman"
    - smooth
    - "all eyes on me"
    - "ghetto gospel"

- family
  lastname: Schapelle
    name:
        Alex
        Shir
  lastname: Schleye
    name:
        Orna
        Efrayim
        Oz
```


---

# Practice (cont.)

```yaml
---

- 

  hosts: db
  gather_facts: False
  vars_files:
    - vars/details.yaml
  tasks: 
    - name: Print the variables
      debug:
        msg: "{{ username }} {{ list_of_songs }} {{ family }}"

```

---

# Ansible Facts

---

- The setup module, and how this relates to fact gathering
- Filtering for specific facts
- The creation of custom facts
- The execution of custom facts
- How custom facts can be used in environments, without super user access
- [RTFM setup module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/setup_module.html)

---

# Examples

- [Setting facts](../04_advance_playbooks/01_facts/00_our_fact.yaml)
- [Setting multiple facts](../04_advance_playbooks/01_facts/01_multi_fact.yaml)
- [Set conditional facts](../04_advance_playbooks/01_facts/02_condition_fact.yaml)

---

# Practice

- Create task for setting modules

---

# Custom Facts

- Can be written in any language
- Return a JSON structure
- (or) Returns an ini structure
- By default, expects to use /etc/ansible/facts.d

---

# Examples
- [Example fact script](../04_advance_playbooks/01_facts/fact_script.sh)
- [Setting custom facts](../04_advance_playbooks/01_facts/03_custom_fact.yaml)

---

# Practice

- Create shell script that returns json format of python version installed on your system
- Create playbook with tasks that:
    - Creates /etc/ansible/facts.d/ folder on all nodes
    - Copies the shell script to remote location of /etc/ansible/facts.d/ on all hosts with name of `python_version.fact`
    - Set the script to be custom fact on remote hosts under /etc/ansible/facts.d/
    - Check with debug module the value of ansible_fact called ansible_local

```sh
#!/bin/bash

python_ver=$(python3 --version | cut -d' ' -f2)

cat << EOF
{ "Python_version": "${python_ver}" }
EOF
```
---

# Practice (cont.)

```yaml
---

- 

  hosts: db
  gather_facts: True

  tasks:
    - name: Create /etc/ansible/facts.d/ folder
      file:
        path: /etc/ansible/facts.d/
        state: directory
        mode: 755

    - name: Copy script to fact folder
        copy:
          src: python.sh
          dest: /etc/ansible/facts.d/python_version.fact
          
    - name:
        setup:
          filter: 
            - 'ansible_local'

```

---

# Templates with Jinja2


---

# Templates

#### what will we see ?

- Jinja2 template language
- Jinja2 module
- jinja2 filters
    - [RTFM playbook filters](https://docs.ansible.com/ansible/2.7/user_guide/playbooks_filters.html) 

---

# Jinja2 templates language

Ansible uses [Jinja2 template engine](https://jinja.palletsprojects.com/en/3.1.x) to enable dynamic expressions and access to variables and facts. You can use jinja2 with the `template` module.

- Use template engine in playbooks directly, by passing values through template to task names and more.
- Use all the standard filters and tests included in Jinja2. 

---

#  Jinja2 templates language (cont.)

Jinja2 templates combine plain text files and special syntax to define and substitute dynamic content, embed variables, expressions, loops, and even conditional statements to generate complex output. According to the documentation, expressions are enclosed in double curly braces `{{ }}`, statements in curly braces with percent signs `{% %}`, and comments in `{# #}.`

---

# Examples

- [template example](../04_advance_playbooks/02_jinja_templates/example_template.j2)
- [simple use](../04_advance_playbooks/02_jinja_templates/00.yaml)
- [config with variables](../04_advance_playbooks/02_jinja_templates/01.yaml)
- [nginx provision](../04_advance_playbooks/02_jinja_templates/02.yaml)

> `[!]` Note: value swapping in templates happens before the task is executed on the target on the `anisble host`

---

# Practice

- Use sshd configuration file below to create sshd.j2 template
    - Change port to variable {{ sshd_port }}
    - Change listen address to {{ sshd_address }}
    - Change usepam to {{ pam_use }}
- Create vars.yaml file that will contain variables
    - sshd_port = 22
    - sshd_address = 0.0.0.0
    - pam_use = yes
- Create task with template module
    - Setup vars.yaml file for the task
    - Use copy module to backup the remote sshd config on all hosts
    - Use template module to deploy the sshd config to all hosts
    - Test by connecting to one of the host to validate

```ini
Include /etc/ssh/sshd_config.d/*.conf
Port 22
ListenAddress 0.0.0.0
PubkeyAuthentication yes
ChallengeResponseAuthentication no
UsePAM yes
AcceptEnv LANG LC_*
Subsystem       sftp    /usr/lib/openssh/sftp-server
```

```yaml

---

-
  host: all
  become: True
  tasks:
    - name: backup remote sshd config
      copy:
        src: /etc/ssh/sshd_config
        dest: /etc/ssh/sshd_config.bk
        remote_src: True

    - name: Template ssh config
      template:
        src: sshd.j2
        dest: /etc/ssh/sshd_config

```

---

# Dynamic inventories

---

- The requirements of dynamic inventories
- How to Create dynamic inventories with minimal scripting
- How to interrogate a dynamic inventory
- Performance enhancements through the use of `_meta`
- The use of the Ansible Python framework for Dynamic Inventories

---

# Inventories

- We've used an inventory of hosts defined via out `ansible.cfg` and `hosts.ini`
- We have associated inventories variables both inline and via host_vars and group_vars directories
- An inventory can be specified and overridden on the command line using `-i` option

---

# Dynamic inventory key requirements

- Needs to be executable file. Can be written in any programming language that it can be executed from the command line
- Accepts command line options of `--list` and `--hosts` hostname
- Returns JSON encoded dictionary of inventory content when used with `--list`
- Returns a basic JSON encoded dictionary structure for `--host` hostname


---

# Example

- [inventory.py](../04_advance_playbooks/03_dynamic_inventory/inventory.py)

---

# Register and when

---

# Register and when

Ansible `register` is a way to capture the output from task execution and store it in a variable. This is an important feature, as this output is different for each remote host, and the basis on that, we can use conditions loops to do some other tasks

---

# Register

We usually run `ansible` command to test out infrastructure, for example:
```sh
ansible all -a 'hostname -s' -o
```
Yet, there are instances when we need to use the output to determine conclusion that `setup` module may not include
- [Saving hostname](../04_advance_playbooks/04_register_and_when/00_register.yaml)

But saving output without checking it has not much value, thus combination of `register` keyword with `debug` module and `var` keyword. We can get the raw data or just accept the  `stdout` of the returned output:

- [User registered data](../04_advance_playbooks/04_register_and_when/01_reg_output.yaml)
- [User registered data with stdout](../04_advance_playbooks/04_register_and_when/02_reg_stdout.yaml)


---

# Register (cont.)

You will store the output of your task in these variables on the Ansible Control Server. In simple words, when you want to run a command on a remote computer, store the output in a variable, and use a piece of information from the output later in your plays.

when we run any module and store its output in a variable, we can access similarly detailed information. We will notice all details about the task execution, and related information will be seen in JSON fields.

You will see most of the fields in the output; we will try to explore some of those.

- `changed` – this will be true or false based on the state of remote hosts. If the state changes, then it will contain true, else it will contain
- `cmd` – This is a command which ran on the remote host
- `failed` – if a task failed or not, it has true or false values
- `RC` – return code
- `stderr` – the standard error message in a single line
- `stdout` – the output in a single line

---

# Practice

- Create task that will issue `uptime` command on debian hosts
- Register all output under variable `uptime_register`
- Add task with `debug` module to show the changes of the variable
- Run the playbook to validates that it is working

```yaml
    - name: Exploring Registers
      command: uptime
      register: uptime_register

    - name: show hostname_output
      debug:
        var: uptime_register

```
---

# When 

In many cases, where we wish to use specific module, plugin or command on specific host and wish to check if host answer the criteria, we use `when` keyword
Many conditions can be evaluated with `and` and `or` boolean operators:

- [Setup Modules with when](../04_advance_playbooks/04_register_and_when/03_setup_when.yaml)
- [Setup Module with when and `and`](../04_advance_playbooks/04_register_and_when/04_setup_when_and.yaml)
- [Setup Module with when and `or` and `and`](../04_advance_playbooks/04_register_and_when/05_setup_when_and_or.yaml)
- [Setup Module with when and `or` and `and`](../04_advance_playbooks/04_register_and_when/06_setup_when_and_list.yaml)


---

# Practice

- Create the task to run `uptime` command that will run only on debian os family distribution
- Run the playbook to validates that it is working

```yaml
    - name: Exploring Registers
      command: uptime
      when: ansible_os_family == "Debian"
```

[RTFM conditions](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_conditionals.html)

---

# When `register` and `when` meet

It's very useful to combine `register` with `when` keyword, due to their beneficial nature. When working on systems, some of them dynamically can be updated, and those parameters may differ from env to env. In those scenarios ansible comes in handy

- [Registering when condition is triggered](../04_advance_playbooks/04_register_and_when/07_register_when.yaml)
- [Registering only changed](../04_advance_playbooks/04_register_and_when/08_register_changed.yaml)
- [Registering only when there `is` change](../04_advance_playbooks/04_register_and_when/09_register_when_is_change.yaml)
- [Registering when there `is` skip](../04_advance_playbooks/04_register_and_when/10_register_when_is_skip.yaml)


---

# Practice


- Create task that run `uptime` command, that will execute only on debian os family and on version 11 and above
- Run the playbook to validates that it is working

```yaml
    - name: Exploring Registers
      command: uptime
      when: 
        - ansible_os_family == "Debian"
        - ansible_distribution_major_version | int >= 11 
```


---

# Loops

---

# Loops

Ansible offers the `loop`, `with_<lookup>`, and `until` keywords to execute a task multiple times. Examples of commonly-used loops include changing ownership on several files and/or directories with the file module, creating multiple users with the user module, and repeating a polling step until a certain result is reached

> `[!]` Note: `loop` was added to Ansible in version 2.5. It is not yet a full replacement for with_<lookup>, but it is recommend it for most use cases.

> `[!]` Note: `with_<lookup>` is NOT deprecated, and syntax will still be valid for the foreseeable future.

> `[!]` Note: `loop` syntax is not final - [thus keep up with docs](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_loops.html)

---

# `loop`

In most cases, loops work best with the `loop` keyword instead of `with_X` style loops.
The `loop` syntax is usually best expressed using filters instead of more complex use of `query` or `lookup`.


```yaml

hosts: all
vars:
  - packages:
    - git
    - build-essential
    - python3-poetry
become: True
tasks:
  - name: 
    package:
      name: "{{ item }}"
      state: latest
    loop:
      - packages
```
---

# Practice

- Create task with:
    - Variable list of users to be created
    - Use `user` module to create the user with loop
- Create new playbook:
    - Create another task:
        - User the same variable list
        - Use `user` module to delete same users
- [RTFM user module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/user_module.html)

---

# Practice

```yaml
hosts: all
vars:
  - users:
    - alex
    - shir
    - michael
    - karen

become: True
tasks:
  - name: Create user "{{ item }}"
    user:
      name: "{{ item }}"
      state: present
    loop:
      - users

  - name: Deleting user "{{ item }}"
    user:
      name: "{{ item }}"
      state: absent
    loop:
      - users

```
---

# `loop` with dictionary

#### `with_dict` substitution with `loop`

`with_dict` can be substituted by loop and either the `dictsort` or `dict2items` filters.

```yaml
hosts: all
vars:
  packages:
    pkg1: git
    pkg2: build-essential
    pkg3: python3-poetry
become: True
tasks:
  - name: Installing {{item.key}}
    package:
      name: "{{ item.value }}"
      state: latest
    loop: "{{packages | dict2items}}"
```

---

# Practice

- Create task with:
    - Variable list of users to be created with user name and comment with full name
    - Use `user` module to create the user with loop
    - Use loop with `dict2items` to serialize several  key value pairs
- Create new playbook:
    - Create another task:
        - User the same variable list
        - Use `user` module to delete same users
- [RTFM user module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/user_module.html)

---

# Practice (cont.)

```yaml
hosts: all
vars:
  users:
    alex:
      full_name: "Alex M. Schapelle"
    shir:
      full_name: "Shir Schleyen"
    michael:
      full_name: "Michael Sepiashvili"
    meli:
      full_name: "Melody Schapelle"
become: True
tasks:
  - name: Create user "{{ item.key }}"
    user:
      name: "{{ item.key }}"
      state: present
      comment: "{{ item.value.full_name }}"
    loop:
      - "{{ users | dict2items }}"

  - name: Deleting user "{{ item.key }}"
    user:
      name: "{{ item.key }}"
      state: absent
      comment: "{{ item.value.full_name }}"
    loop:
      - "{{ users | dict2items }}"
```

---

# Practice (cont.)
Same can be achieved with `dictsort`
```yaml
  - name: Create user "{{ item.key }}"
    user:
      name: "{{ item.0 }}"
      state: present
      comment: "{{ item.1 }}"
    loop:
      - "{{ users | dictsort }}"
```
---

# `loop` with double dictionary

#### `with_subelements`

`with_subelements` is replaced by `loop` and the `subelements` filter.

```yaml
hosts: all
vars:
  users:
    - 
      - lastname: Schapelle
        members:
          - Alex
          - Shir
      - lastname: Golan
        members:
          - Yoni

become: True
tasks:
  - name: Create user "{{ item.1 }}"
    user:
      name: "{{ item.1 }}"
      state: present
      comment: "{{ item.1 |  title }}  {{ item.0.lastname }}"
    loop:
      - "{{ users | subelements }}"
```

---

# Practice


- Create task with:
    - Variable list of users to be created with lastname key and comment with full name
    - Use `user` module to create the user with loop
    - Use loop with `subelements` to serialize items with 0 and 1 to show as key/value and their subelements
- Create new playbook:
    - Create another task:
        - User the same variable list
        - Use `user` module to delete same users
- [RTFM user module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/user_module.html)


---

# `until`

Unlike `loop` and `with_<lookup>`, `until` is a the retry pattern that can be used with any action, in which you would prefer to perform a task until certain condition is met or amount of retries is reached.

for example :
- Lets create shell script that will print out random number within of range of 0 to 10
- lets create a task with until loop that will run this script on all hosts 100 times or until it reaches the output of 10 

```sh
#!/usr/bin/env bash 
echo $((1 + RANDOM % 10))
```

```yaml
- name: Run a script until we get 10
  script: random.sh
  register: result
  retries: 100
  until: result.stdout.find("10") != -1
  # default delay time is 5 seconds when not provided to playbook
  delay: 1
```

---

# Practice

- Write a task that will use `until` loop with 10 `retries` with `delay` of 10 second to implement an alive check for a webapp that is starting up.
- The web app can be accessed on `ansible_all_ipv4_addresses` on port 80 

```yaml
---
- 
  hosts: my-hosts
  tasks:
  - name: check webapp if it is up or not
    uri: 
      url=http://{{ ansible_all_ipv4_addresses }}:8080/alive return_content=yes
    register: result
    until: "result.content.find('OK') != -1"
    retries: 10
    delay: 10

```


---

# Task delegation

---

# Task delegation

Ansible task delegation property or the keyword specified in the ansible-playbook is used to provide the control to run the task locally or to the other different hosts rather than running on the remote hosts specified on the inventory server list, and this can be the few tasks or running the entire play-book locally and also delegating facts to the local machines or the specific set of groups.

There are many playbooks in the projects that sometimes require to run tasks or the entire playbook on the local machine that hosts the inventory file or playbook, or we can say on the different remote hosts that are different from the remote hosts that are mentioned in the inventory list to run tasks  In that situation, we can use the `delegate_to` parameter so that the tasks can run locally.

---

# Example

we have the four tasks which will copy files from the ansible controller to the remote destination; in the second task, we will use the delegate_to parameter to get the URL status from the local or the delegated server only, and in the third task, we will get the output produced by the delegated task, and in the fourth task, ansible will reboot the remote machine.

- [Delegating to localhost](../04_advance_playbooks/06_task_delegation/00_delegate.yaml)


---

# Blocks

---

# Blocks

<!-- https://www.golinuxcloud.com/ansible-block-rescue-always/ -->

Ansible Block and Rescue are powerful features in Ansible, which are used for grouping tasks and handling errors in playbooks. They offer an efficient way to manage complex automation scripts, making them more readable, maintainable, and resilient to failures.

- Grouping tasks with blocks
- Handling errors with blocks


---

# Grouping tasks with blocks

An Ansible Block is a mechanism to group multiple tasks together in an Ansible playbook. The primary purpose of a block is to create logical groupings of tasks, which can be treated as a single unit. This is particularly useful for organizing complex playbooks by breaking them down into smaller, more manageable parts.

- [Example](../04_advance_playbooks/07_blocks/00_block.yaml)

---

# Practice

- Run the example playbook on web hosts
- Change the web hosts to all hosts
- Why is error happening ?

---

# Handling errors with blocks

To handle errors ansible uses `rescue`. It specifies a set of tasks that should be executed if an error occurs in any of the tasks within a block. The rescue section is akin to an exception handling mechanism found in many programming languages

- [Example](../04_advance_playbooks/07_blocks/01_rescue.yaml)

---

# Practice

- Read the rescue yaml example
- Run the the file
- Compare the block and rescue files
- What's the difference


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

# password

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

# template

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

# csvfile

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

---

# Ansible vault

<img src="../99_misc/.img/vault.png" alt="import include" style="border-radius:25px;float:right;width:400px;">

---

Usually at some point in developing ansible playbooks, there is a time, when someone asks regarding the sensitive information. That is when `ansible-vault` come into play. 

Lets see these vault features in action:

- Encrypt/decrypt variables
- Encrypting and decrypting files
- Re-Encrypting data
- Using multiple vaults

---

# Encrypt/decrypt variables

```sh
ansible-vault encrypt_string --ask-vault-pass --name 'ansible_become_pass' 'docker'
```
Once the prompt is provided, we can feed it a generic password, preferably not the same password as we are encrypting. I'll use  _vaultpass_ as password.
The output that we will get we can save at out variables or group_variables files and use it every time run the playbook
---

# Encrypt/decrypt files

Encrypting existing files is a quintessential application of Ansible vault, allowing users to secure pre-existing files containing sensitive data. The `ansible-vault encrypt` command is instrumental in this regard. It takes an already existing plain-text file and encrypts it, making the content secure and unreadable without the appropriate decryption password.

```sh
ansible-vault encrypt existing_file.yaml
```
Upon execution of this command, you'll be prompted to enter a new vault password, which will be used to encrypt the specified file.

Decrypting files is an essential operation when working with Ansible vault encrypted data. The ansible-vault decrypt command is used to revert encrypted files back to their plain text format, making them accessible for viewing or editing outside the vault-encrypted environment.
```sh
ansible-vault decrypt encrypted_file.yaml
```
Executing this command will prompt you for the vault password. Upon entering the correct password, the specified file will be decrypted, revealing its original plain text content.

Decryption should be handled with caution and typically performed when there is a necessity to edit, view, or share the file outside the Ansible vault environment. However, it's vital to minimize the time that sensitive data remains in an unencrypted state to mitigate potential security risks.

Execute the `ansible-vault decrypt` command targeting the desired encrypted file:

```sh
ansible-vault decrypt encrypted_file.yaml
```
Enter the correct vault password when prompted:

```sh
Vault password: ********
```
Ansible vault will decrypt the file, reverting it to its original plain text state, enabling further actions such as viewing or editing the sensitive content.

 
---

# Re-Encrypt data

Ansible vault encompasses a feature known as rekeying, enabled through the ansible-vault rekey command. Rekeying refers to the process of changing the password of an encrypted file without altering the content within the file itself. This feature is vital for maintaining the security and integrity of the encrypted data.

```sh
ansible-vault rekey encrypted_file.yaml
```
Executing this command prompts you for the current vault password, followed by the new password you wish to set. This changes the encryption key, effectively rekeying the file.

---

# Running Playbooks with Vaulted Files

#### Passing Vault Passwords

Executing playbooks that encompass Ansible vault encrypted files necessitates the passage of vault passwords. This enables Ansible to decrypt the vault-encrypted files during runtime, facilitating seamless playbook execution with the incorporated secure data.

#### Using --ask-vault-pass

The `--ask-vault-pass` option prompts you for the vault password interactively when running a playbook. It ensures that the necessary decryption key is available for decrypting any vault-encrypted files or variables used within the playbook.

```sh
ansible-playbook playbook.yaml --ask-vault-pass
```
Upon executing this command, you'll be prompted to enter the vault password, enabling the decryption of the vaulted content within the playbook execution process.

---

# Using Vault Password Files

Alternatively, vault password files can be used to pass the vault password non-interactively. This method involves specifying a file containing the vault password using the `--vault-id` or `--vault-password-file` option.

```sh
ansible-playbook playbook.yaml --vault-id /path/to/vault_password_file
```
#### Configuring `vault_password_file` in ansible.cfg

Locate or create the ansible.cfg file in your project directory or another appropriate location.

Edit the ansible.cfg file and specify the vault_password_file directive under the `[defaults]` section. Provide the path to your vault password file.

```ini
[defaults]
vault_password_file = /path/to/vault_password_file
```
Execute the playbook as you normally would. Due to the configuration, Ansible automatically knows where to find the vault password.
```sh
ansible-playbook playbook.yaml
```
By configuring the vault_password_file directive in the `ansible.cfg`, you're instructing Ansible to automatically use the specified file for the vault password when decrypting vault-encrypted data. This method eliminates the need to manually specify the vault password or password file each time you run a playbook, thereby enhancing efficiency and ease of use in managing Ansible vault encrypted content.


---

# Ansible import and include module

---

# Imports and include

<img src="../99_misc/.img/import.png" alt="import include" style="float:left;width:400px;">

While working on complex playbooks on of the main thing to focus is not to rewrite existing code. This is where  the next list of modules comes in handy

- `include_tasks`: to include external tasks in side of your playbook
- `import_tasks` :  Import task to current playbook 
- Static Vs. dynamic : Difference between the 2 mentioned above

---

# `include` module

We can create separate yaml file which will only contain tasks using the YAML syntax which can be used inside a playbook by using `include` module.
Sadly, the module is going to be deprecated in future versions, yet, some part of it, mainly named `include_task` is preserved and still usable

---

# Example

- [Including task in a playbook](../06_includes_and_import/00_include_task.yaml)

---

# `import` module



Much like the `roles:` keyword, this task loads a role, but it allows you to control when the role tasks run in between other tasks of the play

Most keywords, loops and conditionals will only be applied to the imported tasks, not to this statement itself. If you want the opposite behavior, use ansible.builtin.include_role instead

Roles can not be implemented as part of handlers



---

# Example

- [Importing task in a playbook](../06_includes_and_import/01_import_task.yaml)

#### So what is the difference between `import_task` and `include_task` ?

---

# Static Vs. dynamic

Whenever we use `import_task` or `include_task`, we mostly will not  notice too much of the the difference, due to the execution precedence.
`import` module is pre-processed at the moment the playbook is parse (loaded into memory of the computer). Any playbook pre-loaded with data, is considered to that static value load to playbooks
`include` module is processed while the playbook is running, i.e after the playbook is already running. It is also known as dynamic value load of playbooks.

This is possible to see while using `when` condition on the tasks, during the run of the playbook

---

# Example

- [import task](../06_includes_and_import/02_import_task.yaml)
- [include task](../06_includes_and_import/03_include_task.yaml)
- [playbook that uses both of them](../06_includes_and_import/04_playbook.yaml)

---

# Practice

- Read the last example yaml files
- Run the main playbook file
- Check the differences

---

# Ansible tags

<img src="../99_misc/.img/tags.png" alt="tags" style="border-radius:25px;float:right;width:400px;">

---

# Tags

Ansible tags are used to run only one or some specific tasks from a large playbook instead of running the whole playbook. Lets cover the topics of

- Using and execution of tags with playbooks
- Skip tags


---

# Using and execution of tags with playbooks

When using playbooks, usually the get large, thus it may be useful to run only specific parts of it instead of running the entire playbook. You can do this with Ansible tags. 
Using tags to execute or skip selected tasks is a two-step process:

- Add tags to your tasks, either individually or with tag inheritance from a block, play, role, or import.
- Select or skip tags when you run your playbook.

---

# Using and execution of tags with playbooks

To use tags we only need to add `tag` keyword to the playbook we use, and later use that playbook with `--tags` and the name of the tag we would wish to use. For example

- [Initial use](../../00.yaml) can be done as shown here with command `ansible-playbook 00.yaml --tags epel-install`
- We can also use [multiple tags](../../00.yaml) with separating tags with comma as shown:  `ansible-playbook 00.yaml --tags "epel-install,nginx-install"`

---

# Practice

- Create html with some unique quote in it.
- Add task with tag to copy  html file to nginx dedicated path
- Restart the nginx with tags

```sh
echo "Welcome to web app deployed by ansible" > index.html
```
---

# Practice (cont.)

```yaml
... # only showing relevant code that can be added to 00.yaml

- name: Copy html file to nginx
  copy:
    src: index.html
    dest: /usr/share/nginx/html/index.html
    mode: 644
  when: ansible_distribution == 'Debian'
  tags:
    - app-deploy
...
```

```sh
ansible-playbook 00.yaml --tags app-deploy
ansible-playbook 00.yaml --tags restart-nginx
```



---

# Skipping tags
To inverse the behavior of tags, or in other words to run everything that does not have tags we can use `--skip-tags`

```sh
ansible-playbook 00.yaml --skip-tags "app-deploy"
```
---

# Practice

- Run previous playbook skipping restart-nginx tag

```sh
ansible-playbook 00.yaml --skip-tags "restart-nginx"
```

---

# Ansible Roles
<img src="../99_misc/.img/galaxy.png" alt="galaxy" style="border-radius:25px;float:right;width:400px;">

---

Up until now, we shallow dived into ansible and ansible-playbook, while the idea of all we went through was to work on single command or single playbook. Yet as with everything software connected, working on single file may become tiresome and hard to maintain.
Usually in software development, it is standard to separate part of the software into smaller, digestible parts that can be easily maintained in long period of time. 

#### Enter Ansible Roles

Ansible Role is essentially a way to bundle automation tasks, handlers, default variables, and other assets together. It acts like a blueprint, allowing users to reuse, share, and manage automation structures with ease. By using Ansible Roles, tasks become modular and more straightforward, promoting reusability and simplicity in defining complex configurations and automation

---

# Importance and use cases

The concept of the "Ansible Role" becomes highly valuable when you need to manage complex systems or workflows. Roles are indispensable for organizing and modularizing code into reusable units. They help in breaking down complex tasks into simpler, more manageable pieces, thus making the automation workflows less cluttered and more understandable.

Use cases of Ansible Roles are vast, ranging from configuring system prerequisites and managing users to deploying applications and ensuring that specific services are running on servers. Due to the modular nature of roles, they can be easily shared across different projects, promoting code reuse and consistency.

---

# Architecture and components

An "Ansible Role" is containing several components or directories, each holding specific types of content. Key components include:

- `Tasks`: The main list of tasks that the role will execute.
- `Handlers`: Contains handlers, which may be used by this role or even outside this role.
- `Defaults`: Default variables for the role.
- `Vars`: Other variables for the role.
- `Files` and `Templates`: Contains files or templates which can be deployed by this role.

The structure looks as follows:

<img src="../99_misc/.img/ansible_role.png" alt="roles" style="border-radius:25px;float:right;width:400px;">

> `[!]` Note: this structure can be created manually, yet it is suggested to use `ansible-galaxy` instead, as shown in next segment

> `[!]` Note: NOT all folder are required for roles. essentially you could manage with tasks folder only or var and tasks folders only. The use solely depends on what you are trying to accomplish

---

# Initialization

To initialize or create a new Ansible Role, you can use the ansible-galaxy init command, followed by the role name. For example:

```sh
ansible-galaxy init my_role
```

This command will create a new directory with the name `my_role`, including it with the necessary directories and files based on the default structure.

lets populate some of these files with task and try to use the role:

```yaml
# role_name/tasks/main.yaml
---
- name: Install nginx
  apt:
    name: nginx
    state: present
```

```yaml
# role_name/handlers/main.yaml
---
- name: Restart nginx
  service:
    name: nginx
    state: restarted
```

```yaml
# role_name/defaults/main.yaml
---
nginx_port: 80
```

---

# Practice

- Create role named web_role
- Copy examples from above and insert them into the relevant folders/files


---

# Using ansible roles

#### Including roles in playbooks

Ansible roles are designed to be reusable components in your automation workflows. To leverage the functionalities defined in roles, you include them in playbooks. Here is how you can incorporate Ansible Roles within a playbook:


```yaml
---
# outside of my_role folder in file name my_playbook.yaml
- hosts: web
  roles:
    - role: nginx_role
```

In this example, the playbook is assigned to run on web_servers, and it includes an Ansible Role named nginx_role

---

# Executing the role playbook

Run the playbook using the ansible-playbook command, and the role will be executed on the targeted hosts

```sh
ansible-playbook my_playbook.yaml
```

---

# Practice

- Create playbook called web_playbook.yaml
- Run web_playbook against web hosts

---

# Role Dependencies

Roles can depend on other roles, meaning one role can invoke another. Defining dependencies is crucial for managing complex workflows where tasks are interrelated. Dependencies are typically listed in the meta/main.yaml file inside the role directory.
yaml

```yaml
# meta/main.yaml
dependencies:
  - role: common
```

In this snippet, the Ansible Role has a dependency on another role named common, which would be executed first.

---

# Passing variables to roles

Variables make Ansible Roles highly customizable. When using a role in a playbook, you can pass variables to it to modify its behavior.

```yaml
---
- hosts: web_servers
  roles:
    - role: nginx_role
      vars:
        nginx_port: 8080
```
This playbook executes the nginx_role, passing a variable that sets the Nginx port to 8080

Role Name
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
Role Name
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).

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

Now, each collection can evolve faster, independently, and even be published by different vendors (like AWS, Cisco, or Red Hat).# Using Ansible API

## Introduction
Ansible provides several ways to programmatically interact with its automation engine through APIs. This presentation covers the main approaches to using Ansible's API capabilities.

## 1. Ansible Python API (ansible-runner)
The `ansible-runner` library provides a Python interface to run Ansible playbooks programmatically, offering the most flexible and powerful way to integrate Ansible into your applications.

### Key Features
- Run playbooks directly from Python code
- Capture playbook output and results
- Manage inventory programmatically
- Handle playbook execution and results
- Support for private data directories
- Event-driven execution monitoring
- Async execution capabilities

### Basic Example Usage
```python
import ansible_runner

# Run a playbook
def run_playbook(playbook_path, inventory_path, extra_vars=None):
    r = ansible_runner.run(
        playbook=playbook_path,
        inventory=inventory_path,
        extravars=extra_vars
    )
    return r.status, r.rc, r.events
```

### Advanced Examples

#### 1. Async Playbook Execution
```python
import ansible_runner
import time

def run_async_playbook(playbook_path, inventory_path):
    # Start the playbook execution
    r = ansible_runner.run_async(
        playbook=playbook_path,
        inventory=inventory_path
    )
    
    # Get the job ID
    job_id = r[0]
    
    # Monitor the job status
    while True:
        status = ansible_runner.get_status(job_id)
        if status in ['successful', 'failed', 'error']:
            break
        time.sleep(5)
    
    return status
```

#### 2. Using Private Data Directory
```python
import ansible_runner
import os

def run_with_private_data(playbook_path, inventory_path, private_data_dir):
    # Create private data directory structure
    os.makedirs(private_data_dir, exist_ok=True)
    os.makedirs(os.path.join(private_data_dir, 'project'), exist_ok=True)
    
    # Copy playbook and inventory to private data directory
    # (Implementation depends on your needs)
    
    r = ansible_runner.run(
        playbook=playbook_path,
        inventory=inventory_path,
        private_data_dir=private_data_dir,
        project_dir=os.path.join(private_data_dir, 'project')
    )
    return r.status, r.rc, r.events
```

#### 3. Event-Driven Execution
```python
import ansible_runner
import json

def run_with_event_handler(playbook_path, inventory_path):
    def event_handler(event):
        if event['event'] == 'runner_on_ok':
            print(f"Task completed: {event['event_data']['task']}")
        elif event['event'] == 'runner_on_failed':
            print(f"Task failed: {event['event_data']['task']}")
            print(f"Error: {event['event_data']['res']['msg']}")
    
    r = ansible_runner.run(
        playbook=playbook_path,
        inventory=inventory_path,
        event_handler=event_handler
    )
    return r.status, r.rc, r.events
```

### Practical Solutions

#### 1. Error Handling and Retries
```python
import ansible_runner
import time
from typing import Optional, Tuple

def run_with_retry(
    playbook_path: str,
    inventory_path: str,
    max_retries: int = 3,
    delay: int = 5
) -> Tuple[bool, Optional[dict]]:
    for attempt in range(max_retries):
        try:
            r = ansible_runner.run(
                playbook=playbook_path,
                inventory=inventory_path
            )
            
            if r.status == 'successful':
                return True, r.events
            
            print(f"Attempt {attempt + 1} failed. Retrying in {delay} seconds...")
            time.sleep(delay)
            
        except Exception as e:
            print(f"Error during attempt {attempt + 1}: {str(e)}")
            if attempt < max_retries - 1:
                time.sleep(delay)
    
    return False, None
```

#### 2. Dynamic Inventory Generation
```python
import ansible_runner
import json
import yaml

def run_with_dynamic_inventory(playbook_path: str, hosts: list):
    # Generate dynamic inventory
    inventory = {
        'all': {
            'hosts': {
                host: {} for host in hosts
            }
        }
    }
    
    # Save inventory to temporary file
    inventory_path = 'temp_inventory.yml'
    with open(inventory_path, 'w') as f:
        yaml.dump(inventory, f)
    
    try:
        r = ansible_runner.run(
            playbook=playbook_path,
            inventory=inventory_path
        )
        return r.status, r.rc, r.events
    finally:
        # Clean up temporary inventory file
        os.remove(inventory_path)
```

### Practice Tasks for Ansible Runner

1. **Basic Playbook Execution**
   - Create a simple playbook that installs nginx on a target host
   - Write a Python script using ansible-runner to execute this playbook
   - Add error handling and logging to the script

2. **Async Execution**
   - Modify the nginx installation script to use async execution
   - Implement a progress bar to show the execution status
   - Add timeout handling for long-running tasks

3. **Event-Driven Monitoring**
   - Create a playbook with multiple tasks (e.g., installing packages, configuring services)
   - Implement an event handler that:
     - Logs successful tasks to a file
     - Sends notifications for failed tasks
     - Generates a summary report after completion

4. **Dynamic Inventory**
   - Write a script that:
     - Reads host information from a CSV file
     - Generates a dynamic inventory
     - Executes a playbook against the generated inventory
   - Add support for different host groups based on CSV data

5. **Advanced Error Handling**
   - Implement a retry mechanism for failed playbook executions
   - Add different retry strategies for different types of failures
   - Create a detailed error report with stack traces

### Solutions for Ansible Runner Practice Tasks

#### 1. Basic Playbook Execution Solution

First, create the nginx installation playbook:

```yaml
# install_nginx.yml
---
- name: Install and configure nginx
  hosts: all
  become: true
  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Start nginx service
      service:
        name: nginx
        state: started
        enabled: yes
```

Then, create the Python script to execute it:

```python
import ansible_runner
import logging
import os
from datetime import datetime

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('ansible_execution.log'),
        logging.StreamHandler()
    ]
)

def run_nginx_installation(inventory_path):
    try:
        # Get the playbook path
        playbook_path = os.path.join(os.path.dirname(__file__), 'install_nginx.yml')
        
        # Run the playbook
        r = ansible_runner.run(
            playbook=playbook_path,
            inventory=inventory_path,
            verbosity=2
        )
        
        # Log the results
        if r.status == 'successful':
            logging.info("Nginx installation completed successfully")
            return True, r.events
        else:
            logging.error(f"Nginx installation failed with status: {r.status}")
            return False, r.events
            
    except Exception as e:
        logging.error(f"Error during playbook execution: {str(e)}")
        return False, None

if __name__ == "__main__":
    inventory_path = "hosts.yml"  # Your inventory file
    success, events = run_nginx_installation(inventory_path)
    if success:
        print("Nginx installation completed successfully")
    else:
        print("Nginx installation failed")
```

#### 2. Async Execution Solution

```python
import ansible_runner
import time
from tqdm import tqdm
import logging
from datetime import datetime, timedelta

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class AsyncPlaybookRunner:
    def __init__(self, timeout_minutes=30):
        self.timeout = timedelta(minutes=timeout_minutes)
        
    def run_with_progress(self, playbook_path, inventory_path):
        start_time = datetime.now()
        
        # Start async execution
        r = ansible_runner.run_async(
            playbook=playbook_path,
            inventory=inventory_path
        )
        
        job_id = r[0]
        
        # Create progress bar
        with tqdm(total=100, desc="Playbook Progress") as pbar:
            while True:
                # Check timeout
                if datetime.now() - start_time > self.timeout:
                    logger.error("Playbook execution timed out")
                    return False, "Timeout"
                
                # Get status
                status = ansible_runner.get_status(job_id)
                
                if status == 'successful':
                    pbar.update(100 - pbar.n)
                    return True, "Success"
                elif status in ['failed', 'error']:
                    return False, status
                
                # Update progress (simplified)
                pbar.update(1)
                time.sleep(1)
                
        return False, "Unknown status"

def main():
    runner = AsyncPlaybookRunner(timeout_minutes=30)
    success, status = runner.run_with_progress(
        playbook_path="install_nginx.yml",
        inventory_path="hosts.yml"
    )
    
    if success:
        logger.info("Playbook executed successfully")
    else:
        logger.error(f"Playbook execution failed: {status}")

if __name__ == "__main__":
    main()
```

#### 3. Event-Driven Monitoring Solution

```python
import ansible_runner
import json
import logging
from datetime import datetime
import smtplib
from email.mime.text import MIMEText

class EventHandler:
    def __init__(self, log_file="ansible_events.log", email_config=None):
        self.log_file = log_file
        self.email_config = email_config
        self.successful_tasks = []
        self.failed_tasks = []
        
    def log_event(self, event):
        timestamp = datetime.now().isoformat()
        with open(self.log_file, 'a') as f:
            f.write(f"{timestamp} - {json.dumps(event)}\n")
            
    def send_notification(self, subject, body):
        if not self.email_config:
            return
            
        msg = MIMEText(body)
        msg['Subject'] = subject
        msg['From'] = self.email_config['from']
        msg['To'] = self.email_config['to']
        
        try:
            with smtplib.SMTP(self.email_config['smtp_server']) as server:
                server.starttls()
                server.login(self.email_config['username'], self.email_config['password'])
                server.send_message(msg)
        except Exception as e:
            logging.error(f"Failed to send email: {str(e)}")
            
    def handle_event(self, event):
        self.log_event(event)
        
        if event['event'] == 'runner_on_ok':
            self.successful_tasks.append(event['event_data']['task'])
        elif event['event'] == 'runner_on_failed':
            self.failed_tasks.append(event['event_data']['task'])
            self.send_notification(
                "Ansible Task Failed",
                f"Task failed: {event['event_data']['task']}\nError: {event['event_data']['res']['msg']}"
            )
            
    def generate_report(self):
        report = {
            'timestamp': datetime.now().isoformat(),
            'successful_tasks': self.successful_tasks,
            'failed_tasks': self.failed_tasks,
            'total_tasks': len(self.successful_tasks) + len(self.failed_tasks),
            'success_rate': len(self.successful_tasks) / (len(self.successful_tasks) + len(self.failed_tasks)) if self.successful_tasks or self.failed_tasks else 0
        }
        
        with open('execution_report.json', 'w') as f:
            json.dump(report, f, indent=2)
            
        return report
            
def run_with_monitoring(playbook_path, inventory_path, email_config=None):
    handler = EventHandler(email_config=email_config)
    
    r = ansible_runner.run(
        playbook=playbook_path,
        inventory=inventory_path,
        event_handler=handler.handle_event
    )
    
    report = handler.generate_report()
    return r.status, r.rc, report

if __name__ == "__main__":
    email_config = {
        'smtp_server': 'smtp.example.com',
        'username': 'your_username',
        'password': 'your_password',
        'from': 'ansible@example.com',
        'to': 'admin@example.com'
    }
    
    status, rc, report = run_with_monitoring(
        playbook_path="install_nginx.yml",
        inventory_path="hosts.yml",
        email_config=email_config
    )
    
    print(f"Execution completed with status: {status}")
    print(f"Success rate: {report['success_rate']*100:.2f}%")
```

#### 4. Dynamic Inventory Solution

```python
import ansible_runner
import csv
import yaml
import os
import tempfile
from typing import Dict, List

class DynamicInventory:
    def __init__(self, csv_file: str):
        self.csv_file = csv_file
        self.inventory: Dict = {
            'all': {
                'hosts': {},
                'children': {}
            }
        }
        
    def read_csv(self) -> List[Dict]:
        hosts = []
        with open(self.csv_file, 'r') as f:
            reader = csv.DictReader(f)
            for row in reader:
                hosts.append(row)
        return hosts
        
    def generate_inventory(self) -> Dict:
        hosts = self.read_csv()
        
        for host in hosts:
            # Add host to all.hosts
            self.inventory['all']['hosts'][host['hostname']] = {
                'ansible_host': host['ip'],
                'ansible_user': host['user'],
                'ansible_ssh_private_key_file': host['ssh_key']
            }
            
            # Add host to appropriate group
            group = host.get('group', 'ungrouped')
            if group not in self.inventory['all']['children']:
                self.inventory['all']['children'][group] = {
                    'hosts': {}
                }
            self.inventory['all']['children'][group]['hosts'][host['hostname']] = {}
            
        return self.inventory
        
    def save_inventory(self, path: str):
        with open(path, 'w') as f:
            yaml.dump(self.inventory, f)
            
def run_with_dynamic_inventory(playbook_path: str, csv_file: str):
    # Create temporary directory for inventory
    with tempfile.TemporaryDirectory() as temp_dir:
        inventory_path = os.path.join(temp_dir, 'inventory.yml')
        
        # Generate and save inventory
        inventory = DynamicInventory(csv_file)
        inventory_data = inventory.generate_inventory()
        inventory.save_inventory(inventory_path)
        
        # Run playbook
        r = ansible_runner.run(
            playbook=playbook_path,
            inventory=inventory_path
        )
        
        return r.status, r.rc, r.events

if __name__ == "__main__":
    # Example CSV file structure:
    # hostname,ip,user,ssh_key,group
    # web1,192.168.1.10,admin,/path/to/key,webservers
    # db1,192.168.1.11,admin,/path/to/key,databases
    
    status, rc, events = run_with_dynamic_inventory(
        playbook_path="install_nginx.yml",
        csv_file="hosts.csv"
    )
    
    print(f"Playbook execution completed with status: {status}")
```

#### 5. Advanced Error Handling Solution

```python
import ansible_runner
import time
import logging
import json
from typing import Optional, Tuple, Dict
from enum import Enum
import traceback

class ErrorType(Enum):
    CONNECTION = "connection"
    PERMISSION = "permission"
    PACKAGE = "package"
    SERVICE = "service"
    UNKNOWN = "unknown"

class RetryStrategy:
    def __init__(self, max_retries: int = 3, delay: int = 5):
        self.max_retries = max_retries
        self.delay = delay
        
    def should_retry(self, error_type: ErrorType) -> bool:
        if error_type == ErrorType.CONNECTION:
            return True
        elif error_type == ErrorType.PERMISSION:
            return False  # Don't retry permission issues
        elif error_type == ErrorType.PACKAGE:
            return True
        elif error_type == ErrorType.SERVICE:
            return True
        return False
        
    def get_delay(self, error_type: ErrorType) -> int:
        if error_type == ErrorType.CONNECTION:
            return self.delay * 2  # Longer delay for connection issues
        return self.delay

class ErrorHandler:
    def __init__(self):
        self.error_log = []
        
    def classify_error(self, error_msg: str) -> ErrorType:
        error_msg = error_msg.lower()
        if "connection refused" in error_msg or "timeout" in error_msg:
            return ErrorType.CONNECTION
        elif "permission denied" in error_msg:
            return ErrorType.PERMISSION
        elif "package" in error_msg or "apt" in error_msg:
            return ErrorType.PACKAGE
        elif "service" in error_msg or "systemd" in error_msg:
            return ErrorType.SERVICE
        return ErrorType.UNKNOWN
        
    def log_error(self, error: Exception, attempt: int):
        error_type = self.classify_error(str(error))
        error_entry = {
            'timestamp': time.time(),
            'attempt': attempt,
            'error_type': error_type.value,
            'error_message': str(error),
            'stack_trace': traceback.format_exc()
        }
        self.error_log.append(error_entry)
        
    def generate_error_report(self) -> Dict:
        return {
            'total_errors': len(self.error_log),
            'errors_by_type': self._count_errors_by_type(),
            'error_details': self.error_log
        }
        
    def _count_errors_by_type(self) -> Dict[str, int]:
        counts = {}
        for error in self.error_log:
            error_type = error['error_type']
            counts[error_type] = counts.get(error_type, 0) + 1
        return counts

def run_with_advanced_error_handling(
    playbook_path: str,
    inventory_path: str,
    max_retries: int = 3,
    delay: int = 5
) -> Tuple[bool, Optional[Dict]]:
    retry_strategy = RetryStrategy(max_retries, delay)
    error_handler = ErrorHandler()
    
    for attempt in range(max_retries):
        try:
            r = ansible_runner.run(
                playbook=playbook_path,
                inventory=inventory_path
            )
            
            if r.status == 'successful':
                return True, r.events
                
            # Handle playbook failure
            error_type = error_handler.classify_error(str(r.events))
            if not retry_strategy.should_retry(error_type):
                error_handler.log_error(Exception(str(r.events)), attempt)
                return False, error_handler.generate_error_report()
                
            print(f"Attempt {attempt + 1} failed. Retrying in {retry_strategy.get_delay(error_type)} seconds...")
            time.sleep(retry_strategy.get_delay(error_type))
            
        except Exception as e:
            error_handler.log_error(e, attempt)
            if not retry_strategy.should_retry(error_handler.classify_error(str(e))):
                return False, error_handler.generate_error_report()
                
            print(f"Error during attempt {attempt + 1}: {str(e)}")
            if attempt < max_retries - 1:
                time.sleep(retry_strategy.get_delay(error_handler.classify_error(str(e))))
    
    return False, error_handler.generate_error_report()

if __name__ == "__main__":
    success, result = run_with_advanced_error_handling(
        playbook_path="install_nginx.yml",
        inventory_path="hosts.yml"
    )
    
    if success:
        print("Playbook executed successfully")
    else:
        print("Playbook execution failed")
        print("Error Report:")
        print(json.dumps(result, indent=2))
```

## 2. Ansible CLI as API
Ansible's command-line interface can be wrapped to create a simple API-like interface.

### Key Features
- Simple to implement
- No additional dependencies
- Direct access to all Ansible features
- Easy integration with existing scripts

### Example Usage
```python
import subprocess

def run_ansible_command(playbook_path, inventory_path, extra_vars=None):
    cmd = ['ansible-playbook', playbook_path, '-i', inventory_path]
    if extra_vars:
        cmd.extend(['-e', json.dumps(extra_vars)])
    
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.returncode, result.stdout, result.stderr
```

### Solutions for CLI API Practice Tasks

#### 1. Basic CLI Integration Solution

```python
import subprocess
import json
import yaml
from typing import Dict, Optional, Tuple
import logging

class AnsiblePlaybookRunner:
    def __init__(self, ansible_path: str = "ansible-playbook"):
        self.ansible_path = ansible_path
        self.logger = logging.getLogger(__name__)
        
    def run(
        self,
        playbook_path: str,
        inventory_path: str,
        extra_vars: Optional[Dict] = None,
        check_mode: bool = False,
        diff_mode: bool = False,
        output_format: str = "json"
    ) -> Tuple[int, str, str]:
        """
        Run an Ansible playbook with various options
        """
        cmd = [self.ansible_path, playbook_path, "-i", inventory_path]
        
        if check_mode:
            cmd.append("--check")
        if diff_mode:
            cmd.append("--diff")
            
        if extra_vars:
            cmd.extend(["-e", json.dumps(extra_vars)])
            
        if output_format == "json":
            cmd.append("--output", "json")
            
        try:
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                check=False
            )
            
            self.logger.info(f"Playbook execution completed with return code: {result.returncode}")
            return result.returncode, result.stdout, result.stderr
            
        except subprocess.CalledProcessError as e:
            self.logger.error(f"Error running playbook: {str(e)}")
            return e.returncode, e.stdout, e.stderr
            
    def validate_playbook(self, playbook_path: str) -> bool:
        """
        Validate playbook syntax
        """
        cmd = [self.ansible_path, "--syntax-check", playbook_path]
        try:
            result = subprocess.run(cmd, capture_output=True, text=True)
            return result.returncode == 0
        except subprocess.CalledProcessError:
            return False
            
    def get_playbook_vars(self, playbook_path: str) -> Dict:
        """
        Extract variables from playbook
        """
        cmd = [self.ansible_path, "--list-vars", playbook_path]
        try:
            result = subprocess.run(cmd, capture_output=True, text=True)
            if result.returncode == 0:
                return yaml.safe_load(result.stdout)
            return {}
        except Exception as e:
            self.logger.error(f"Error getting playbook variables: {str(e)}")
            return {}

def main():
    runner = AnsiblePlaybookRunner()
    
    # Example usage
    playbook_path = "install_nginx.yml"
    inventory_path = "hosts.yml"
    
    # Validate playbook
    if not runner.validate_playbook(playbook_path):
        print("Playbook validation failed")
        return
        
    # Get variables
    vars = runner.get_playbook_vars(playbook_path)
    print(f"Playbook variables: {vars}")
    
    # Run playbook
    rc, stdout, stderr = runner.run(
        playbook_path=playbook_path,
        inventory_path=inventory_path,
        check_mode=True,
        diff_mode=True
    )
    
    if rc == 0:
        print("Playbook executed successfully")
    else:
        print(f"Playbook execution failed: {stderr}")
```

#### 2. Command Execution Solution

```python
import subprocess
import json
from typing import Dict, List, Optional
import logging
from dataclasses import dataclass
from datetime import datetime

@dataclass
class CommandResult:
    host: str
    success: bool
    output: str
    error: Optional[str]
    execution_time: float

class AnsibleAdHocRunner:
    def __init__(self, ansible_path: str = "ansible"):
        self.ansible_path = ansible_path
        self.logger = logging.getLogger(__name__)
        
    def run_command(
        self,
        hosts: List[str],
        command: str,
        become: bool = False,
        module: str = "shell",
        output_format: str = "json"
    ) -> List[CommandResult]:
        """
        Run an ad-hoc command on multiple hosts
        """
        results = []
        
        for host in hosts:
            start_time = datetime.now()
            
            cmd = [
                self.ansible_path,
                host,
                "-m", module,
                "-a", command
            ]
            
            if become:
                cmd.append("-b")
                
            if output_format == "json":
                cmd.append("--output", "json")
                
            try:
                result = subprocess.run(
                    cmd,
                    capture_output=True,
                    text=True,
                    check=False
                )
                
                execution_time = (datetime.now() - start_time).total_seconds()
                
                if result.returncode == 0:
                    results.append(CommandResult(
                        host=host,
                        success=True,
                        output=result.stdout,
                        error=None,
                        execution_time=execution_time
                    ))
                else:
                    results.append(CommandResult(
                        host=host,
                        success=False,
                        output="",
                        error=result.stderr,
                        execution_time=execution_time
                    ))
                    
            except subprocess.CalledProcessError as e:
                results.append(CommandResult(
                    host=host,
                    success=False,
                    output="",
                    error=str(e),
                    execution_time=(datetime.now() - start_time).total_seconds()
                ))
                
        return results
        
    def format_results(self, results: List[CommandResult]) -> str:
        """
        Format command results for display
        """
        output = []
        for result in results:
            output.append(f"\nHost: {result.host}")
            output.append(f"Success: {result.success}")
            output.append(f"Execution Time: {result.execution_time:.2f}s")
            if result.success:
                output.append("Output:")
                output.append(result.output)
            else:
                output.append("Error:")
                output.append(result.error)
        return "\n".join(output)

def main():
    runner = AnsibleAdHocRunner()
    
    # Example usage
    hosts = ["web1", "web2", "db1"]
    command = "df -h"
    
    results = runner.run_command(
        hosts=hosts,
        command=command,
        become=True
    )
    
    print(runner.format_results(results))
```

#### 3. Inventory Management Solution

```python
import yaml
import json
from typing import Dict, List, Optional
import os
import logging
from dataclasses import dataclass

@dataclass
class Host:
    name: str
    ip: str
    groups: List[str]
    vars: Dict

class InventoryManager:
    def __init__(self, inventory_path: str):
        self.inventory_path = inventory_path
        self.logger = logging.getLogger(__name__)
        self.inventory = self._load_inventory()
        
    def _load_inventory(self) -> Dict:
        """
        Load inventory from file
        """
        try:
            with open(self.inventory_path, 'r') as f:
                return yaml.safe_load(f)
        except Exception as e:
            self.logger.error(f"Error loading inventory: {str(e)}")
            return {'all': {'hosts': {}, 'children': {}}}
            
    def _save_inventory(self):
        """
        Save inventory to file
        """
        try:
            with open(self.inventory_path, 'w') as f:
                yaml.dump(self.inventory, f)
        except Exception as e:
            self.logger.error(f"Error saving inventory: {str(e)}")
            
    def add_host(self, host: Host):
        """
        Add a new host to inventory
        """
        # Add to all.hosts
        self.inventory['all']['hosts'][host.name] = {
            'ansible_host': host.ip,
            **host.vars
        }
        
        # Add to groups
        for group in host.groups:
            if group not in self.inventory['all']['children']:
                self.inventory['all']['children'][group] = {'hosts': {}}
            self.inventory['all']['children'][group]['hosts'][host.name] = {}
            
        self._save_inventory()
        
    def remove_host(self, hostname: str):
        """
        Remove a host from inventory
        """
        # Remove from all.hosts
        if hostname in self.inventory['all']['hosts']:
            del self.inventory['all']['hosts'][hostname]
            
        # Remove from groups
        for group in self.inventory['all']['children']:
            if hostname in self.inventory['all']['children'][group]['hosts']:
                del self.inventory['all']['children'][group]['hosts'][hostname]
                
        self._save_inventory()
        
    def add_group(self, groupname: str, parent: Optional[str] = None):
        """
        Add a new group to inventory
        """
        if parent:
            if parent not in self.inventory['all']['children']:
                self.inventory['all']['children'][parent] = {'children': {}}
            self.inventory['all']['children'][parent]['children'][groupname] = {'hosts': {}}
        else:
            self.inventory['all']['children'][groupname] = {'hosts': {}}
            
        self._save_inventory()
        
    def validate_inventory(self) -> bool:
        """
        Validate inventory structure
        """
        try:
            # Check required sections
            if 'all' not in self.inventory:
                return False
            if 'hosts' not in self.inventory['all']:
                return False
            if 'children' not in self.inventory['all']:
                return False
                
            # Validate hosts
            for hostname, host_vars in self.inventory['all']['hosts'].items():
                if not isinstance(host_vars, dict):
                    return False
                    
            # Validate groups
            for groupname, group_data in self.inventory['all']['children'].items():
                if not isinstance(group_data, dict):
                    return False
                if 'hosts' not in group_data:
                    return False
                    
            return True
            
        except Exception as e:
            self.logger.error(f"Error validating inventory: {str(e)}")
            return False

def main():
    # Example usage
    inventory_path = "hosts.yml"
    manager = InventoryManager(inventory_path)
    
    # Add a new host
    new_host = Host(
        name="web3",
        ip="192.168.1.13",
        groups=["webservers", "production"],
        vars={
            "ansible_user": "admin",
            "ansible_ssh_private_key_file": "/path/to/key"
        }
    )
    manager.add_host(new_host)
    
    # Add a new group
    manager.add_group("staging")
    
    # Validate inventory
    if manager.validate_inventory():
        print("Inventory is valid")
    else:
        print("Inventory validation failed")
```

#### 4. Variable Management Solution

```python
import yaml
import json
from typing import Dict, Any, Optional
import logging
from pathlib import Path
import sqlite3
from dataclasses import dataclass

@dataclass
class Variable:
    name: str
    value: Any
    source: str
    priority: int

class VariableManager:
    def __init__(self, db_path: str = "ansible_vars.db"):
        self.db_path = db_path
        self.logger = logging.getLogger(__name__)
        self._init_db()
        
    def _init_db(self):
        """
        Initialize SQLite database
        """
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS variables (
                name TEXT PRIMARY KEY,
                value TEXT,
                source TEXT,
                priority INTEGER
            )
        ''')
        
        conn.commit()
        conn.close()
        
    def add_variable(self, variable: Variable):
        """
        Add a variable to the database
        """
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        try:
            cursor.execute('''
                INSERT OR REPLACE INTO variables (name, value, source, priority)
                VALUES (?, ?, ?, ?)
            ''', (
                variable.name,
                json.dumps(variable.value),
                variable.source,
                variable.priority
            ))
            conn.commit()
        except Exception as e:
            self.logger.error(f"Error adding variable: {str(e)}")
        finally:
            conn.close()
            
    def get_variable(self, name: str) -> Optional[Variable]:
        """
        Get a variable from the database
        """
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        try:
            cursor.execute('''
                SELECT value, source, priority
                FROM variables
                WHERE name = ?
            ''', (name,))
            
            result = cursor.fetchone()
            if result:
                return Variable(
                    name=name,
                    value=json.loads(result[0]),
                    source=result[1],
                    priority=result[2]
                )
            return None
            
        except Exception as e:
            self.logger.error(f"Error getting variable: {str(e)}")
            return None
        finally:
            conn.close()
            
    def load_from_file(self, file_path: str, source: str, priority: int):
        """
        Load variables from a file
        """
        try:
            with open(file_path, 'r') as f:
                if file_path.endswith('.yml') or file_path.endswith('.yaml'):
                    vars_dict = yaml.safe_load(f)
                else:
                    vars_dict = json.load(f)
                    
            for name, value in vars_dict.items():
                self.add_variable(Variable(
                    name=name,
                    value=value,
                    source=source,
                    priority=priority
                ))
                
        except Exception as e:
            self.logger.error(f"Error loading variables from file: {str(e)}")
            
    def generate_vars_file(self, output_path: str):
        """
        Generate a variables file with merged values
        """
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        try:
            cursor.execute('''
                SELECT name, value
                FROM variables
                ORDER BY priority DESC
            ''')
            
            vars_dict = {}
            for name, value in cursor.fetchall():
                vars_dict[name] = json.loads(value)
                
            with open(output_path, 'w') as f:
                yaml.dump(vars_dict, f)
                
        except Exception as e:
            self.logger.error(f"Error generating vars file: {str(e)}")
        finally:
            conn.close()
            
    def validate_variable(self, name: str, value: Any) -> bool:
        """
        Validate a variable value
        """
        # Add your validation rules here
        if isinstance(value, str):
            return len(value) > 0
        elif isinstance(value, (int, float)):
            return True
        elif isinstance(value, dict):
            return all(isinstance(k, str) for k in value.keys())
        elif isinstance(value, list):
            return all(isinstance(x, (str, int, float)) for x in value)
        return False

def main():
    manager = VariableManager()
    
    # Load variables from files
    manager.load_from_file("group_vars/all.yml", "group_vars", 1)
    manager.load_from_file("host_vars/web1.yml", "host_vars", 2)
    
    # Add a variable
    manager.add_variable(Variable(
        name="app_version",
        value="1.0.0",
        source="manual",
        priority=3
    ))
    
    # Get a variable
    var = manager.get_variable("app_version")
    if var:
        print(f"Variable value: {var.value}")
        
    # Generate vars file
    manager.generate_vars_file("merged_vars.yml")
```

#### 5. Output Processing Solution

```python
import json
import yaml
from typing import Dict, List, Optional
import logging
from dataclasses import dataclass
from datetime import datetime
import re

@dataclass
class TaskResult:
    task_name: str
    host: str
    status: str
    duration: float
    error: Optional[str]
    changed: bool

class OutputProcessor:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        
    def parse_playbook_output(self, output: str) -> List[TaskResult]:
        """
        Parse ansible-playbook output
        """
        results = []
        current_task = None
        
        for line in output.split('\n'):
            # Task start
            if line.startswith('TASK ['):
                task_match = re.match(r'TASK \[(.*?)\]', line)
                if task_match:
                    current_task = task_match.group(1)
                    
            # Task result
            elif line.startswith('ok:') or line.startswith('fatal:'):
                host_match = re.match(r'(ok|fatal): \[(.*?)\]', line)
                if host_match and current_task:
                    status = host_match.group(1)
                    host = host_match.group(2)
                    
                    # Extract duration
                    duration_match = re.search(r'in (\d+\.\d+)s', line)
                    duration = float(duration_match.group(1)) if duration_match else 0.0
                    
                    # Extract error if any
                    error = None
                    if status == 'fatal':
                        error_match = re.search(r'msg: (.*?)$', line)
                        if error_match:
                            error = error_match.group(1)
                            
                    # Determine if task changed anything
                    changed = 'changed=' in line and 'changed=1' in line
                    
                    results.append(TaskResult(
                        task_name=current_task,
                        host=host,
                        status=status,
                        duration=duration,
                        error=error,
                        changed=changed
                    ))
                    
        return results
        
    def generate_report(self, results: List[TaskResult], format: str = "json") -> str:
        """
        Generate a report from task results
        """
        report = {
            'timestamp': datetime.now().isoformat(),
            'total_tasks': len(results),
            'successful_tasks': len([r for r in results if r.status == 'ok']),
            'failed_tasks': len([r for r in results if r.status == 'fatal']),
            'changed_tasks': len([r for r in results if r.changed]),
            'total_duration': sum(r.duration for r in results),
            'tasks': [
                {
                    'name': r.task_name,
                    'host': r.host,
                    'status': r.status,
                    'duration': r.duration,
                    'error': r.error,
                    'changed': r.changed
                }
                for r in results
            ]
        }
        
        if format == "json":
            return json.dumps(report, indent=2)
        else:
            return yaml.dump(report)
            
    def analyze_performance(self, results: List[TaskResult]) -> Dict:
        """
        Analyze task performance
        """
        analysis = {
            'slowest_tasks': [],
            'most_failed_tasks': {},
            'host_performance': {}
        }
        
        # Sort tasks by duration
        sorted_tasks = sorted(results, key=lambda x: x.duration, reverse=True)
        analysis['slowest_tasks'] = [
            {
                'task_name': r.task_name,
                'host': r.host,
                'duration': r.duration
            }
            for r in sorted_tasks[:5]
        ]
        
        # Count task failures
        for r in results:
            if r.status == 'fatal':
                if r.task_name not in analysis['most_failed_tasks']:
                    analysis['most_failed_tasks'][r.task_name] = 0
                analysis['most_failed_tasks'][r.task_name] += 1
                
        # Calculate host performance
        for r in results:
            if r.host not in analysis['host_performance']:
                analysis['host_performance'][r.host] = {
                    'total_tasks': 0,
                    'successful_tasks': 0,
                    'failed_tasks': 0,
                    'total_duration': 0.0
                }
                
            host_stats = analysis['host_performance'][r.host]
            host_stats['total_tasks'] += 1
            if r.status == 'ok':
                host_stats['successful_tasks'] += 1
            elif r.status == 'fatal':
                host_stats['failed_tasks'] += 1
            host_stats['total_duration'] += r.duration
            
        return analysis

def main():
    processor = OutputProcessor()
    
    # Example usage
    with open('ansible_output.txt', 'r') as f:
        output = f.read()
        
    results = processor.parse_playbook_output(output)
    
    # Generate report
    report = processor.generate_report(results, format="json")
    print("Execution Report:")
    print(report)
    
    # Analyze performance
    analysis = processor.analyze_performance(results)
    print("\nPerformance Analysis:")
    print(json.dumps(analysis, indent=2))
```

## 3. Ansible Tower/AWX REST API
The most comprehensive way to interact with Ansible programmatically is through the Ansible Tower/AWX REST API.

### Key Features
- Full REST API interface
- Authentication and authorization
- Job scheduling and monitoring
- Inventory management
- Project and template management
- User and team management

### Example Usage
```python
import requests
import json

# Tower API endpoint
TOWER_URL = "https://your-tower-instance/api/v2"
TOKEN = "your-auth-token"

# Headers for authentication
headers = {
    'Authorization': f'Bearer {TOKEN}',
    'Content-Type': 'application/json'
}

# Launch a job template
def launch_job_template(template_id, extra_vars=None):
    url = f"{TOWER_URL}/job_templates/{template_id}/launch/"
    data = {
        "extra_vars": extra_vars or {}
    }
    response = requests.post(url, headers=headers, json=data)
    return response.json()
```

### Practice Tasks for Tower/AWX API

1. **Authentication and Authorization**
   - Implement a secure token management system
   - Create a connection manager class
   - Add support for different authentication methods

2. **Job Template Management**
   - Write a script to:
     - Create and manage job templates
     - Schedule jobs
     - Monitor job execution status

3. **Inventory Management**
   - Create a system to:
     - Manage Tower inventories programmatically
     - Sync inventory with external sources
     - Handle inventory group hierarchies

4. **Project Management**
   - Implement functionality to:
     - Create and update projects
     - Sync with version control systems
     - Manage project permissions

5. **Reporting System**
   - Build a reporting tool that:
     - Collects job execution data
     - Generates performance metrics
     - Creates visual reports

## Best Practices

1. **Error Handling**
   - Always implement proper error handling
   - Check return codes and status messages
   - Log errors appropriately

2. **Security**
   - Use secure authentication methods
   - Never store credentials in code
   - Implement proper access controls

3. **Performance**
   - Use async operations when possible
   - Implement proper timeout handling
   - Cache results when appropriate

4. **Maintenance**
   - Keep dependencies updated
   - Document API usage
   - Implement version control

### Practice Tasks for Best Practices

#### 1. Error Handling Implementation Solution

```python
import logging
import sys
from typing import Optional, Dict, Any
from datetime import datetime
import json
from pathlib import Path

class ErrorHandler:
    def __init__(self, log_dir: str = "logs"):
        self.log_dir = Path(log_dir)
        self.log_dir.mkdir(exist_ok=True)
        
        # Configure logging
        self.logger = logging.getLogger("ansible_api")
        self.logger.setLevel(logging.DEBUG)
        
        # File handler
        log_file = self.log_dir / f"ansible_api_{datetime.now().strftime('%Y%m%d')}.log"
        file_handler = logging.FileHandler(log_file)
        file_handler.setLevel(logging.DEBUG)
        
        # Console handler
        console_handler = logging.StreamHandler(sys.stdout)
        console_handler.setLevel(logging.INFO)
        
        # Formatter
        formatter = logging.Formatter(
            '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
        )
        file_handler.setFormatter(formatter)
        console_handler.setFormatter(formatter)
        
        self.logger.addHandler(file_handler)
        self.logger.addHandler(console_handler)
        
    def handle_error(self, error: Exception, context: Optional[Dict] = None) -> Dict[str, Any]:
        """
        Handle and log an error
        """
        error_info = {
            'timestamp': datetime.now().isoformat(),
            'error_type': type(error).__name__,
            'error_message': str(error),
            'context': context or {},
            'stack_trace': self._get_stack_trace(error)
        }
        
        # Log error
        self.logger.error(
            f"Error: {error_info['error_message']}",
            extra=error_info
        )
        
        # Save error details
        self._save_error_details(error_info)
        
        return error_info
        
    def _get_stack_trace(self, error: Exception) -> str:
        """
        Get formatted stack trace
        """
        import traceback
        return traceback.format_exc()
        
    def _save_error_details(self, error_info: Dict[str, Any]):
        """
        Save error details to file
        """
        error_file = self.log_dir / f"errors_{datetime.now().strftime('%Y%m%d')}.json"
        
        try:
            if error_file.exists():
                with open(error_file, 'r') as f:
                    errors = json.load(f)
            else:
                errors = []
                
            errors.append(error_info)
            
            with open(error_file, 'w') as f:
                json.dump(errors, f, indent=2)
                
        except Exception as e:
            self.logger.error(f"Error saving error details: {str(e)}")
            
    def recover_from_error(self, error_info: Dict[str, Any]) -> bool:
        """
        Attempt to recover from an error
        """
        try:
            # Implement recovery logic based on error type
            if error_info['error_type'] == 'ConnectionError':
                return self._recover_connection()
            elif error_info['error_type'] == 'TimeoutError':
                return self._recover_timeout()
            else:
                return False
                
        except Exception as e:
            self.logger.error(f"Error during recovery: {str(e)}")
            return False
            
    def _recover_connection(self) -> bool:
        """
        Recover from connection error
        """
        # Implement connection recovery logic
        return True
        
    def _recover_timeout(self) -> bool:
        """
        Recover from timeout error
        """
        # Implement timeout recovery logic
        return True

def main():
    # Example usage
    handler = ErrorHandler()
    
    try:
        # Simulate an error
        raise ConnectionError("Failed to connect to Ansible Tower")
    except Exception as e:
        error_info = handler.handle_error(e, {'operation': 'connect_to_tower'})
        
        if handler.recover_from_error(error_info):
            print("Successfully recovered from error")
        else:
            print("Failed to recover from error")
```

#### 2. Security Implementation Solution

```python
import os
import json
import logging
from typing import Dict, Optional
from datetime import datetime, timedelta
import jwt
from cryptography.fernet import Fernet
from pathlib import Path

class CredentialManager:
    def __init__(self, secret_key: Optional[str] = None):
        self.secret_key = secret_key or Fernet.generate_key()
        self.cipher_suite = Fernet(self.secret_key)
        self.logger = logging.getLogger(__name__)
        
    def encrypt_credentials(self, credentials: Dict) -> str:
        """
        Encrypt credentials
        """
        try:
            json_data = json.dumps(credentials)
            encrypted_data = self.cipher_suite.encrypt(json_data.encode())
            return encrypted_data.decode()
        except Exception as e:
            self.logger.error(f"Error encrypting credentials: {str(e)}")
            raise
            
    def decrypt_credentials(self, encrypted_data: str) -> Dict:
        """
        Decrypt credentials
        """
        try:
            decrypted_data = self.cipher_suite.decrypt(encrypted_data.encode())
            return json.loads(decrypted_data.decode())
        except Exception as e:
            self.logger.error(f"Error decrypting credentials: {str(e)}")
            raise

class TokenManager:
    def __init__(self, secret_key: str):
        self.secret_key = secret_key
        self.logger = logging.getLogger(__name__)
        
    def generate_token(self, user_id: str, roles: list) -> str:
        """
        Generate JWT token
        """
        try:
            payload = {
                'user_id': user_id,
                'roles': roles,
                'exp': datetime.utcnow() + timedelta(hours=24)
            }
            return jwt.encode(payload, self.secret_key, algorithm='HS256')
        except Exception as e:
            self.logger.error(f"Error generating token: {str(e)}")
            raise
            
    def validate_token(self, token: str) -> Optional[Dict]:
        """
        Validate JWT token
        """
        try:
            return jwt.decode(token, self.secret_key, algorithms=['HS256'])
        except jwt.ExpiredSignatureError:
            self.logger.warning("Token has expired")
            return None
        except jwt.InvalidTokenError:
            self.logger.warning("Invalid token")
            return None
        except Exception as e:
            self.logger.error(f"Error validating token: {str(e)}")
            return None

class AccessControl:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        self.roles = {}
        self.permissions = {}
        
    def add_role(self, role: str, permissions: list):
        """
        Add a role with permissions
        """
        self.roles[role] = permissions
        
    def check_permission(self, role: str, permission: str) -> bool:
        """
        Check if role has permission
        """
        return permission in self.roles.get(role, [])
        
    def audit_log(self, user_id: str, action: str, resource: str, status: str):
        """
        Log access attempts
        """
        log_entry = {
            'timestamp': datetime.now().isoformat(),
            'user_id': user_id,
            'action': action,
            'resource': resource,
            'status': status
        }
        
        self.logger.info(f"Access attempt: {json.dumps(log_entry)}")
        
        # Save to audit log file
        audit_file = Path("logs/audit.log")
        audit_file.parent.mkdir(exist_ok=True)
        
        with open(audit_file, 'a') as f:
            f.write(json.dumps(log_entry) + '\n')

def main():
    # Example usage
    
    # Initialize managers
    credential_manager = CredentialManager()
    token_manager = TokenManager("your-secret-key")
    access_control = AccessControl()
    
    # Set up roles and permissions
    access_control.add_role("admin", ["read", "write", "execute"])
    access_control.add_role("user", ["read"])
    
    # Encrypt credentials
    credentials = {
        "username": "admin",
        "password": "secret-password"
    }
    encrypted = credential_manager.encrypt_credentials(credentials)
    
    # Generate token
    token = token_manager.generate_token("user1", ["user"])
    
    # Validate token
    payload = token_manager.validate_token(token)
    if payload:
        user_id = payload['user_id']
        roles = payload['roles']
        
        # Check permissions
        if access_control.check_permission(roles[0], "read"):
            access_control.audit_log(user_id, "read", "inventory", "success")
            print("Access granted")
        else:
            access_control.audit_log(user_id, "read", "inventory", "denied")
            print("Access denied")
```

#### 3. Performance Optimization Solution

```python
import time
import logging
from typing import Dict, Any, Optional
from functools import wraps
import threading
from concurrent.futures import ThreadPoolExecutor
import redis
import json

class PerformanceMonitor:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        self.metrics = {}
        self.lock = threading.Lock()
        
    def measure_time(self, func):
        """
        Decorator to measure function execution time
        """
        @wraps(func)
        def wrapper(*args, **kwargs):
            start_time = time.time()
            result = func(*args, **kwargs)
            end_time = time.time()
            
            duration = end_time - start_time
            self.record_metric(func.__name__, duration)
            
            return result
        return wrapper
        
    def record_metric(self, name: str, value: float):
        """
        Record a performance metric
        """
        with self.lock:
            if name not in self.metrics:
                self.metrics[name] = []
            self.metrics[name].append(value)
            
    def get_statistics(self) -> Dict[str, Dict[str, float]]:
        """
        Calculate statistics for all metrics
        """
        stats = {}
        with self.lock:
            for name, values in self.metrics.items():
                if values:
                    stats[name] = {
                        'min': min(values),
                        'max': max(values),
                        'avg': sum(values) / len(values),
                        'count': len(values)
                    }
        return stats

class CacheManager:
    def __init__(self, redis_url: str = "redis://localhost:6379/0"):
        self.redis = redis.from_url(redis_url)
        self.logger = logging.getLogger(__name__)
        
    def get(self, key: str) -> Optional[Any]:
        """
        Get value from cache
        """
        try:
            data = self.redis.get(key)
            return json.loads(data) if data else None
        except Exception as e:
            self.logger.error(f"Error getting from cache: {str(e)}")
            return None
            
    def set(self, key: str, value: Any, expire: int = 3600):
        """
        Set value in cache
        """
        try:
            self.redis.setex(
                key,
                expire,
                json.dumps(value)
            )
        except Exception as e:
            self.logger.error(f"Error setting cache: {str(e)}")
            
    def delete(self, key: str):
        """
        Delete value from cache
        """
        try:
            self.redis.delete(key)
        except Exception as e:
            self.logger.error(f"Error deleting from cache: {str(e)}")

class AsyncExecutor:
    def __init__(self, max_workers: int = 4):
        self.executor = ThreadPoolExecutor(max_workers=max_workers)
        self.logger = logging.getLogger(__name__)
        
    def execute(self, func, *args, **kwargs):
        """
        Execute function asynchronously
        """
        try:
            future = self.executor.submit(func, *args, **kwargs)
            return future
        except Exception as e:
            self.logger.error(f"Error executing async task: {str(e)}")
            raise
            
    def shutdown(self):
        """
        Shutdown the executor
        """
        self.executor.shutdown()

def main():
    # Example usage
    
    # Initialize managers
    monitor = PerformanceMonitor()
    cache = CacheManager()
    executor = AsyncExecutor()
    
    @monitor.measure_time
    def expensive_operation():
        time.sleep(2)  # Simulate expensive operation
        return "result"
        
    # Use cache
    def get_data(key: str):
        # Try cache first
        cached_data = cache.get(key)
        if cached_data:
            return cached_data
            
        # If not in cache, perform expensive operation
        result = expensive_operation()
        cache.set(key, result)
        return result
        
    # Execute async
    future = executor.execute(get_data, "my_key")
    result = future.result()
    
    # Get performance statistics
    stats = monitor.get_statistics()
    print("Performance Statistics:")
    print(json.dumps(stats, indent=2))
    
    # Cleanup
    executor.shutdown()
```

#### 4. Maintenance Tools Solution

```python
import pkg_resources
import logging
from typing import Dict, List, Optional
import subprocess
import json
from pathlib import Path
import git
from datetime import datetime

class DependencyManager:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        
    def get_installed_packages(self) -> Dict[str, str]:
        """
        Get installed package versions
        """
        return {pkg.key: pkg.version for pkg in pkg_resources.working_set}
        
    def check_updates(self) -> List[Dict[str, str]]:
        """
        Check for package updates
        """
        updates = []
        for pkg in pkg_resources.working_set:
            try:
                latest = pkg_resources.get_distribution(pkg.key).version
                if latest != pkg.version:
                    updates.append({
                        'package': pkg.key,
                        'current': pkg.version,
                        'latest': latest
                    })
            except Exception as e:
                self.logger.error(f"Error checking updates for {pkg.key}: {str(e)}")
        return updates
        
    def update_package(self, package: str) -> bool:
        """
        Update a package
        """
        try:
            subprocess.run(
                [sys.executable, "-m", "pip", "install", "--upgrade", package],
                check=True
            )
            return True
        except subprocess.CalledProcessError as e:
            self.logger.error(f"Error updating package {package}: {str(e)}")
            return False

class VersionControl:
    def __init__(self, repo_path: str):
        self.repo_path = Path(repo_path)
        self.logger = logging.getLogger(__name__)
        
    def init_repo(self) -> bool:
        """
        Initialize git repository
        """
        try:
            if not self.repo_path.exists():
                self.repo_path.mkdir(parents=True)
                
            repo = git.Repo.init(self.repo_path)
            return True
        except Exception as e:
            self.logger.error(f"Error initializing repository: {str(e)}")
            return False
            
    def add_file(self, file_path: str, message: str) -> bool:
        """
        Add and commit a file
        """
        try:
            repo = git.Repo(self.repo_path)
            repo.index.add([file_path])
            repo.index.commit(message)
            return True
        except Exception as e:
            self.logger.error(f"Error adding file: {str(e)}")
            return False
            
    def create_branch(self, branch_name: str) -> bool:
        """
        Create a new branch
        """
        try:
            repo = git.Repo(self.repo_path)
            repo.create_head(branch_name)
            return True
        except Exception as e:
            self.logger.error(f"Error creating branch: {str(e)}")
            return False

class DocumentationGenerator:
    def __init__(self, output_dir: str):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(exist_ok=True)
        self.logger = logging.getLogger(__name__)
        
    def generate_api_docs(self, api_info: Dict):
        """
        Generate API documentation
        """
        try:
            # Generate HTML documentation
            html_content = f"""
            <html>
            <head>
                <title>API Documentation</title>
                <style>
                    body {{ font-family: Arial, sans-serif; margin: 20px; }}
                    .endpoint {{ margin: 20px; padding: 20px; border: 1px solid #ccc; }}
                    .method {{ font-weight: bold; color: #0066cc; }}
                </style>
            </head>
            <body>
                <h1>API Documentation</h1>
                <p>Generated on: {datetime.now().isoformat()}</p>
                {self._generate_endpoint_docs(api_info)}
            </body>
            </html>
            """
            
            with open(self.output_dir / "api_docs.html", 'w') as f:
                f.write(html_content)
                
        except Exception as e:
            self.logger.error(f"Error generating API docs: {str(e)}")
            
    def _generate_endpoint_docs(self, api_info: Dict) -> str:
        """
        Generate endpoint documentation
        """
        docs = []
        for endpoint, info in api_info.items():
            docs.append(f"""
            <div class="endpoint">
                <h2>{endpoint}</h2>
                <p class="method">{info['method']}</p>
                <p>{info['description']}</p>
                <h3>Parameters:</h3>
                <ul>
                    {self._generate_parameter_docs(info.get('parameters', []))}
                </ul>
                <h3>Response:</h3>
                <pre>{json.dumps(info.get('response', {}), indent=2)}</pre>
            </div>
            """)
        return "\n".join(docs)
        
    def _generate_parameter_docs(self, parameters: List[Dict]) -> str:
        """
        Generate parameter documentation
        """
        return "\n".join(
            f"<li>{param['name']}: {param['type']} - {param['description']}"
            for param in parameters
        )

def main():
    # Example usage
    
    # Initialize managers
    dep_manager = DependencyManager()
    vc = VersionControl("ansible_api")
    doc_gen = DocumentationGenerator("docs")
    
    # Check for updates
    updates = dep_manager.check_updates()
    if updates:
        print("Available updates:")
        print(json.dumps(updates, indent=2))
        
        # Update packages
        for update in updates:
            if dep_manager.update_package(update['package']):
                print(f"Updated {update['package']}")
                
    # Version control operations
    if vc.init_repo():
        vc.add_file("main.py", "Initial commit")
        vc.create_branch("feature/new-feature")
        
    # Generate documentation
    api_info = {
        "/api/v1/jobs": {
            "method": "GET",
            "description": "List all jobs",
            "parameters": [
                {
                    "name": "status",
                    "type": "string",
                    "description": "Filter by status"
                }
            ],
            "response": {
                "jobs": [
                    {
                        "id": 1,
                        "status": "successful"
                    }
                ]
            }
        }
    }
    
    doc_gen.generate_api_docs(api_info)
```

### Solutions for Common Use Cases Practice Tasks

#### 1. CI/CD Integration Solution

```python
import subprocess
import logging
from typing import Dict, Optional
import json
from pathlib import Path
import time

class CICDPipeline:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        
    def run_tests(self) -> bool:
        """
        Run automated tests
        """
        try:
            # Run pytest
            result = subprocess.run(
                ["pytest", "-v"],
                capture_output=True,
                text=True
            )
            
            if result.returncode == 0:
                self.logger.info("Tests passed successfully")
                return True
            else:
                self.logger.error(f"Tests failed: {result.stderr}")
                return False
                
        except Exception as e:
            self.logger.error(f"Error running tests: {str(e)}")
            return False
            
    def deploy(self, environment: str) -> bool:
        """
        Deploy to specified environment
        """
        try:
            # Run Ansible playbook
            result = subprocess.run(
                [
                    "ansible-playbook",
                    f"deploy_{environment}.yml",
                    "-i", f"inventory_{environment}"
                ],
                capture_output=True,
                text=True
            )
            
            if result.returncode == 0:
                self.logger.info(f"Deployment to {environment} successful")
                return True
            else:
                self.logger.error(f"Deployment failed: {result.stderr}")
                return False
                
        except Exception as e:
            self.logger.error(f"Error during deployment: {str(e)}")
            return False
            
    def rollback(self, environment: str) -> bool:
        """
        Rollback deployment
        """
        try:
            # Run rollback playbook
            result = subprocess.run(
                [
                    "ansible-playbook",
                    f"rollback_{environment}.yml",
                    "-i", f"inventory_{environment}"
                ],
                capture_output=True,
                text=True
            )
            
            if result.returncode == 0:
                self.logger.info(f"Rollback successful")
                return True
            else:
                self.logger.error(f"Rollback failed: {result.stderr}")
                return False
                
        except Exception as e:
            self.logger.error(f"Error during rollback: {str(e)}")
            return False

class DeploymentManager:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        self.deployment_history = []
        
    def deploy_with_rollback(self, environment: str) -> bool:
        """
        Deploy with automatic rollback on failure
        """
        pipeline = CICDPipeline()
        
        # Run tests
        if not pipeline.run_tests():
            self.logger.error("Tests failed, aborting deployment")
            return False
            
        # Record deployment start
        deployment = {
            'environment': environment,
            'start_time': time.time(),
            'status': 'in_progress'
        }
        self.deployment_history.append(deployment)
        
        # Attempt deployment
        if pipeline.deploy(environment):
            deployment['status'] = 'successful'
            deployment['end_time'] = time.time()
            return True
        else:
            # Rollback on failure
            self.logger.info("Deployment failed, initiating rollback")
            if pipeline.rollback(environment):
                deployment['status'] = 'rolled_back'
                deployment['end_time'] = time.time()
                return False
            else:
                deployment['status'] = 'rollback_failed'
                deployment['end_time'] = time.time()
                return False
                
    def get_deployment_history(self) -> List[Dict]:
        """
        Get deployment history
        """
        return self.deployment_history

def main():
    # Example usage
    manager = DeploymentManager()
    
    # Deploy to staging
    success = manager.deploy_with_rollback("staging")
    if success:
        print("Deployment successful")
    else:
        print("Deployment failed")
        
    # Print deployment history
    print("\nDeployment History:")
    print(json.dumps(manager.get_deployment_history(), indent=2))
```

#### 2. Monitoring System Solution

```python
import psutil
import logging
from typing import Dict, List, Optional
import json
from datetime import datetime
import requests
from dataclasses import dataclass

@dataclass
class SystemMetric:
    name: str
    value: float
    unit: str
    timestamp: str

class SystemMonitor:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        
    def collect_metrics(self) -> List[SystemMetric]:
        """
        Collect system metrics
        """
        metrics = []
        
        # CPU metrics
        cpu_percent = psutil.cpu_percent(interval=1)
        metrics.append(SystemMetric(
            name="cpu_usage",
            value=cpu_percent,
            unit="percent",
            timestamp=datetime.now().isoformat()
        ))
        
        # Memory metrics
        memory = psutil.virtual_memory()
        metrics.append(SystemMetric(
            name="memory_usage",
            value=memory.percent,
            unit="percent",
            timestamp=datetime.now().isoformat()
        ))
        
        # Disk metrics
        disk = psutil.disk_usage('/')
        metrics.append(SystemMetric(
            name="disk_usage",
            value=disk.percent,
            unit="percent",
            timestamp=datetime.now().isoformat()
        ))
        
        return metrics
        
    def check_thresholds(self, metrics: List[SystemMetric]) -> List[Dict]:
        """
        Check metrics against thresholds
        """
        alerts = []
        thresholds = {
            "cpu_usage": 80,
            "memory_usage": 85,
            "disk_usage": 90
        }
        
        for metric in metrics:
            if metric.name in thresholds:
                if metric.value > thresholds[metric.name]:
                    alerts.append({
                        'metric': metric.name,
                        'value': metric.value,
                        'threshold': thresholds[metric.name],
                        'timestamp': metric.timestamp
                    })
                    
        return alerts

class AlertManager:
    def __init__(self, webhook_url: Optional[str] = None):
        self.webhook_url = webhook_url
        self.logger = logging.getLogger(__name__)
        
    def send_alert(self, alert: Dict):
        """
        Send alert notification
        """
        if self.webhook_url:
            try:
                response = requests.post(
                    self.webhook_url,
                    json=alert
                )
                response.raise_for_status()
            except Exception as e:
                self.logger.error(f"Error sending alert: {str(e)}")
                
        # Log alert
        self.logger.warning(
            f"Alert: {alert['metric']} exceeded threshold "
            f"({alert['value']} > {alert['threshold']})"
        )

class DashboardGenerator:
    def __init__(self, output_dir: str):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(exist_ok=True)
        self.logger = logging.getLogger(__name__)
        
    def generate_dashboard(self, metrics: List[SystemMetric]):
        """
        Generate monitoring dashboard
        """
        try:
            # Create HTML dashboard
            html_content = f"""
            <html>
            <head>
                <title>System Monitoring Dashboard</title>
                <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
                <style>
                    body {{ font-family: Arial, sans-serif; margin: 20px; }}
                    .metric {{ margin: 20px; padding: 20px; border: 1px solid #ccc; }}
                </style>
            </head>
            <body>
                <h1>System Monitoring Dashboard</h1>
                <p>Generated on: {datetime.now().isoformat()}</p>
                {self._generate_metric_charts(metrics)}
            </body>
            </html>
            """
            
            with open(self.output_dir / "dashboard.html", 'w') as f:
                f.write(html_content)
                
        except Exception as e:
            self.logger.error(f"Error generating dashboard: {str(e)}")
            
    def _generate_metric_charts(self, metrics: List[SystemMetric]) -> str:
        """
        Generate metric charts
        """
        charts = []
        for metric in metrics:
            charts.append(f"""
            <div class="metric">
                <h2>{metric.name}</h2>
                <div id="chart_{metric.name}"></div>
                <script>
                    var data = [{{
                        y: [{metric.value}],
                        type: 'bar'
                    }}];
                    var layout = {{
                        title: '{metric.name}',
                        yaxis: {{
                            title: '{metric.unit}'
                        }}
                    }};
                    Plotly.newPlot('chart_{metric.name}', data, layout);
                </script>
            </div>
            """)
        return "\n".join(charts)

def main():
    # Example usage
    
    # Initialize components
    monitor = SystemMonitor()
    alert_manager = AlertManager("https://your-webhook-url")
    dashboard = DashboardGenerator("dashboard")
    
    # Collect metrics
    metrics = monitor.collect_metrics()
    
    # Check for alerts
    alerts = monitor.check_thresholds(metrics)
    for alert in alerts:
        alert_manager.send_alert(alert)
        
    # Generate dashboard
    dashboard.generate_dashboard(metrics)
```

#### 3. Resource Management Solution

```python
import boto3
import logging
from typing import Dict, List, Optional
import json
from datetime import datetime
import time

class CloudResourceManager:
    def __init__(self, region: str = "us-west-2"):
        self.region = region
        self.logger = logging.getLogger(__name__)
        self.ec2 = boto3.client('ec2', region_name=region)
        
    def provision_instance(self, instance_config: Dict) -> Optional[str]:
        """
        Provision EC2 instance
        """
        try:
            response = self.ec2.run_instances(
                ImageId=instance_config['image_id'],
                InstanceType=instance_config['instance_type'],
                KeyName=instance_config['key_name'],
                MinCount=1,
                MaxCount=1,
                TagSpecifications=[
                    {
                        'ResourceType': 'instance',
                        'Tags': [
                            {'Key': 'Name', 'Value': instance_config['name']},
                            {'Key': 'Environment', 'Value': instance_config['environment']}
                        ]
                    }
                ]
            )
            
            instance_id = response['Instances'][0]['InstanceId']
            self.logger.info(f"Provisioned instance: {instance_id}")
            return instance_id
            
        except Exception as e:
            self.logger.error(f"Error provisioning instance: {str(e)}")
            return None
            
    def terminate_instance(self, instance_id: str) -> bool:
        """
        Terminate EC2 instance
        """
        try:
            self.ec2.terminate_instances(InstanceIds=[instance_id])
            self.logger.info(f"Terminated instance: {instance_id}")
            return True
        except Exception as e:
            self.logger.error(f"Error terminating instance: {str(e)}")
            return False
            
    def get_instance_status(self, instance_id: str) -> Optional[str]:
        """
        Get instance status
        """
        try:
            response = self.ec2.describe_instances(InstanceIds=[instance_id])
            return response['Reservations'][0]['Instances'][0]['State']['Name']
        except Exception as e:
            self.logger.error(f"Error getting instance status: {str(e)}")
            return None

class ConfigurationManager:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        
    def apply_configuration(self, host: str, config: Dict) -> bool:
        """
        Apply configuration to host
        """
        try:
            # Run Ansible playbook
            result = subprocess.run(
                [
                    "ansible-playbook",
                    "configure.yml",
                    "-i", f"{host},",
                    "-e", json.dumps(config)
                ],
                capture_output=True,
                text=True
            )
            
            if result.returncode == 0:
                self.logger.info(f"Configuration applied to {host}")
                return True
            else:
                self.logger.error(f"Configuration failed: {result.stderr}")
                return False
                
        except Exception as e:
            self.logger.error(f"Error applying configuration: {str(e)}")
            return False

class ScalingManager:
    def __init__(self, cloud_manager: CloudResourceManager, config_manager: ConfigurationManager):
        self.cloud_manager = cloud_manager
        self.config_manager = config_manager
        self.logger = logging.getLogger(__name__)
        
    def scale_up(self, count: int, instance_config: Dict) -> List[str]:
        """
        Scale up resources
        """
        instance_ids = []
        for _ in range(count):
            instance_id = self.cloud_manager.provision_instance(instance_config)
            if instance_id:
                instance_ids.append(instance_id)
                
                # Wait for instance to be running
                while self.cloud_manager.get_instance_status(instance_id) != 'running':
                    time.sleep(10)
                    
                # Apply configuration
                self.config_manager.apply_configuration(
                    instance_config['public_ip'],
                    instance_config['config']
                )
                
        return instance_ids
        
    def scale_down(self, instance_ids: List[str]) -> bool:
        """
        Scale down resources
        """
        success = True
        for instance_id in instance_ids:
            if not self.cloud_manager.terminate_instance(instance_id):
                success = False
        return success

def main():
    # Example usage
    
    # Initialize managers
    cloud_manager = CloudResourceManager()
    config_manager = ConfigurationManager()
    scaling_manager = ScalingManager(cloud_manager, config_manager)
    
    # Instance configuration
    instance_config = {
        'image_id': 'ami-0c55b159cbfafe1f0',
        'instance_type': 't2.micro',
        'key_name': 'my-key',
        'name': 'web-server',
        'environment': 'production',
        'config': {
            'nginx_port': 80,
            'app_version': '1.0.0'
        }
    }
    
    # Scale up
    instance_ids = scaling_manager.scale_up(2, instance_config)
    print(f"Scaled up instances: {instance_ids}")
    
    # Scale down
    if scaling_manager.scale_down(instance_ids):
        print("Successfully scaled down")
    else:
        print("Error scaling down")
```

## Conclusion

The Ansible API provides powerful ways to integrate Ansible automation into your applications and workflows. Choose the appropriate API based on your specific needs:

- Use ansible-runner for direct playbook execution and maximum flexibility
- Use CLI wrapping for simple integration
- Use Tower/AWX API for enterprise features and management

Remember to follow best practices and implement proper error handling and security measures in your implementations.
# Ansible and Containers

## Introduction
This presentation covers how to use Ansible to manage and automate container environments, including Docker and Kubernetes. We'll explore various approaches and best practices for container management with Ansible.

## 1. Ansible with Docker

### Key Features
- Container lifecycle management
- Image building and management
- Container networking
- Volume management
- Container orchestration
- Health checks and monitoring

### Basic Example Usage
```yaml
# docker_basic.yml
---
- name: Manage Docker containers
  hosts: all
  become: true
  tasks:
    - name: Install Docker
      apt:
        name: docker.io
        state: present
        update_cache: yes

    - name: Start Docker service
      service:
        name: docker
        state: started
        enabled: yes

    - name: Pull nginx image
      docker_image:
        name: nginx
        source: pull
        force_source: yes

    - name: Run nginx container
      docker_container:
        name: web
        image: nginx
        state: started
        ports:
          - "80:80"
```

### Practice Tasks for Docker

1. **Container Lifecycle Management**
   - Create a playbook that:
     - Builds a custom Docker image
     - Runs multiple containers
     - Manages container networks
     - Handles container volumes

2. **Container Health Monitoring**
   - Implement a monitoring system that:
     - Checks container health
     - Monitors resource usage
     - Handles container restarts
     - Logs container events

3. **Container Networking**
   - Create a network management system that:
     - Sets up container networks
     - Configures network policies
     - Manages container communication
     - Handles network isolation

4. **Container Security**
   - Build a security management system that:
     - Implements container security policies
     - Manages container secrets
     - Handles container access control
     - Monitors security events

5. **Container Backup and Recovery**
   - Develop a backup system that:
     - Backs up container data
     - Manages container snapshots
     - Handles container migration
     - Implements recovery procedures

### Solutions for Docker Practice Tasks

#### 1. Container Lifecycle Management Solution

```yaml
# docker_lifecycle.yml
---
- name: Manage Docker containers lifecycle
  hosts: all
  become: true
  vars:
    app_name: myapp
    app_version: 1.0.0
    container_ports:
      - "8080:80"
      - "443:443"
    volumes:
      - "/data:/app/data"
      - "/config:/app/config"

  tasks:
    - name: Create Docker network
      docker_network:
        name: app_network
        state: present
        driver: bridge

    - name: Build custom Docker image
      docker_image:
        name: "{{ app_name }}:{{ app_version }}"
        source: build
        build:
          context: ./app
          dockerfile: Dockerfile
        force_source: yes

    - name: Create data directory
      file:
        path: /data
        state: directory
        mode: '0755'

    - name: Create config directory
      file:
        path: /config
        state: directory
        mode: '0755'

    - name: Run application container
      docker_container:
        name: "{{ app_name }}"
        image: "{{ app_name }}:{{ app_version }}"
        state: started
        ports: "{{ container_ports }}"
        volumes: "{{ volumes }}"
        networks:
          - name: app_network
        restart_policy: unless-stopped
        healthcheck:
          test: ["CMD", "curl", "-f", "http://localhost:80/health"]
          interval: 30s
          timeout: 10s
          retries: 3
```

#### 2. Container Health Monitoring Solution

```yaml
# docker_monitoring.yml
---
- name: Monitor Docker containers
  hosts: all
  become: true
  vars:
    monitoring_interval: 60
    alert_thresholds:
      cpu: 80
      memory: 85
      disk: 90

  tasks:
    - name: Install monitoring tools
      apt:
        name: 
          - prometheus
          - node-exporter
          - cadvisor
        state: present
        update_cache: yes

    - name: Configure Prometheus
      template:
        src: prometheus.yml.j2
        dest: /etc/prometheus/prometheus.yml
      notify: restart prometheus

    - name: Configure Node Exporter
      template:
        src: node-exporter.service.j2
        dest: /etc/systemd/system/node-exporter.service
      notify: restart node-exporter

    - name: Configure cAdvisor
      template:
        src: cadvisor.service.j2
        dest: /etc/systemd/system/cadvisor.service
      notify: restart cadvisor

    - name: Start monitoring services
      systemd:
        name: "{{ item }}"
        state: started
        enabled: yes
      loop:
        - prometheus
        - node-exporter
        - cadvisor

  handlers:
    - name: restart prometheus
      systemd:
        name: prometheus
        state: restarted

    - name: restart node-exporter
      systemd:
        name: node-exporter
        state: restarted

    - name: restart cadvisor
      systemd:
        name: cadvisor
        state: restarted
```

#### 3. Container Networking Solution

```yaml
# docker_networking.yml
---
- name: Manage Docker networking
  hosts: all
  become: true
  vars:
    networks:
      - name: frontend
        driver: bridge
        options:
          com.docker.network.bridge.name: frontend
      - name: backend
        driver: bridge
        options:
          com.docker.network.bridge.name: backend
      - name: database
        driver: bridge
        options:
          com.docker.network.bridge.name: database

  tasks:
    - name: Create Docker networks
      docker_network:
        name: "{{ item.name }}"
        driver: "{{ item.driver }}"
        options: "{{ item.options }}"
        state: present
      loop: "{{ networks }}"

    - name: Configure network policies
      template:
        src: network-policies.yml.j2
        dest: /etc/docker/network-policies.yml

    - name: Apply network policies
      docker_container:
        name: "{{ item.name }}"
        networks:
          - name: "{{ item.network }}"
        state: started
      loop:
        - name: web
          network: frontend
        - name: app
          network: backend
        - name: db
          network: database
```

#### 4. Container Security Solution

```yaml
# docker_security.yml
---
- name: Implement Docker security
  hosts: all
  become: true
  vars:
    security_policies:
      - name: no_root
        value: true
      - name: read_only
        value: true
      - name: no_new_privileges
        value: true
      - name: capabilities_drop:
        value: ["ALL"]

  tasks:
    - name: Configure Docker daemon security
      template:
        src: daemon.json.j2
        dest: /etc/docker/daemon.json
      notify: restart docker

    - name: Create secrets directory
      file:
        path: /etc/docker/secrets
        state: directory
        mode: '0700'

    - name: Manage Docker secrets
      docker_secret:
        name: "{{ item.name }}"
        data: "{{ item.data }}"
        state: present
      loop:
        - name: db_password
          data: "{{ vault_db_password }}"
        - name: api_key
          data: "{{ vault_api_key }}"

    - name: Apply security policies to containers
      docker_container:
        name: "{{ item.name }}"
        security_opts: "{{ security_policies }}"
        state: started
      loop:
        - name: web
        - name: app
        - name: db

  handlers:
    - name: restart docker
      systemd:
        name: docker
        state: restarted
```

#### 5. Container Backup and Recovery Solution

```yaml
# docker_backup.yml
---
- name: Manage Docker container backups
  hosts: all
  become: true
  vars:
    backup_dir: /backup/docker
    containers:
      - name: web
        volumes:
          - "/data/web:/app/data"
      - name: app
        volumes:
          - "/data/app:/app/data"
      - name: db
        volumes:
          - "/data/db:/var/lib/mysql"

  tasks:
    - name: Create backup directory
      file:
        path: "{{ backup_dir }}"
        state: directory
        mode: '0755'

    - name: Backup container data
      docker_container:
        name: "{{ item.name }}"
        state: started
      loop: "{{ containers }}"
      register: container_status

    - name: Create container snapshots
      command: >
        docker commit {{ item.item.name }} {{ item.item.name }}_snapshot
      loop: "{{ container_status.results }}"
      when: item.state.started

    - name: Backup container volumes
      archive:
        path: "{{ item.volumes | map('regex_replace', '^([^:]+):.*$', '\\1') | list }}"
        dest: "{{ backup_dir }}/{{ item.name }}_volumes.tar.gz"
        format: gz
      loop: "{{ containers }}"

    - name: Backup container configurations
      template:
        src: container-config.yml.j2
        dest: "{{ backup_dir }}/{{ item.name }}_config.yml"
      loop: "{{ containers }}"

    - name: Clean up old snapshots
      command: >
        docker rmi {{ item.item.name }}_snapshot
      loop: "{{ container_status.results }}"
      when: item.state.started
```

## 2. Ansible with Kubernetes

### Key Features
- Cluster management
- Resource deployment
- Service management
- Configuration management
- Secret management
- Scaling operations

### Basic Example Usage
```yaml
# kubernetes_basic.yml
---
- name: Deploy application to Kubernetes
  hosts: localhost
  gather_facts: false
  tasks:
    - name: Create namespace
      kubernetes.core.k8s:
        name: myapp
        api_version: v1
        kind: Namespace
        state: present

    - name: Deploy application
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: apps/v1
          kind: Deployment
          metadata:
            name: myapp
            namespace: myapp
          spec:
            replicas: 3
            selector:
              matchLabels:
                app: myapp
            template:
              metadata:
                labels:
                  app: myapp
              spec:
                containers:
                - name: myapp
                  image: myapp:1.0.0
                  ports:
                  - containerPort: 80
```

### Practice Tasks for Kubernetes

1. **Cluster Management**
   - Create a playbook that:
     - Sets up a Kubernetes cluster
     - Manages node roles
     - Handles cluster upgrades
     - Monitors cluster health

2. **Resource Deployment**
   - Implement a deployment system that:
     - Deploys applications
     - Manages resources
     - Handles rollbacks
     - Monitors deployments

3. **Service Management**
   - Build a service management system that:
     - Creates services
     - Manages load balancing
     - Handles service discovery
     - Monitors service health

4. **Configuration Management**
   - Develop a configuration system that:
     - Manages ConfigMaps
     - Handles secrets
     - Updates configurations
     - Monitors changes

5. **Scaling Operations**
   - Create a scaling system that:
     - Scales resources
     - Manages autoscaling
     - Handles resource limits
     - Monitors scaling events

### Solutions for Kubernetes Practice Tasks

#### 1. Cluster Management Solution

```yaml
# kubernetes_cluster.yml
---
- name: Manage Kubernetes cluster
  hosts: all
  become: true
  vars:
    kubernetes_version: "1.24.0"
    cluster_name: "my-cluster"
    master_nodes:
      - name: master1
        ip: "192.168.1.10"
      - name: master2
        ip: "192.168.1.11"
    worker_nodes:
      - name: worker1
        ip: "192.168.1.20"
      - name: worker2
        ip: "192.168.1.21"

  tasks:
    - name: Install required packages
      apt:
        name:
          - apt-transport-https
          - ca-certificates
          - curl
          - software-properties-common
        state: present
        update_cache: yes

    - name: Add Kubernetes GPG key
      apt_key:
        url: https://packages.cloud.google.com/apt/doc/apt-key.gpg
        state: present

    - name: Add Kubernetes repository
      apt_repository:
        repo: "deb https://apt.kubernetes.io/ kubernetes-xenial main"
        state: present

    - name: Install Kubernetes packages
      apt:
        name:
          - kubelet
          - kubeadm
          - kubectl
        state: present
        version: "{{ kubernetes_version }}"

    - name: Initialize master node
      command: >
        kubeadm init --pod-network-cidr=10.244.0.0/16
      when: inventory_hostname in master_nodes | map(attribute='name') | list

    - name: Join worker nodes to cluster
      command: >
        kubeadm join {{ master_nodes[0].ip }}:6443 --token {{ token }} --discovery-token-ca-cert-hash {{ hash }}
      when: inventory_hostname in worker_nodes | map(attribute='name') | list

    - name: Configure kubectl for admin
      blockinfile:
        path: /root/.kube/config
        create: yes
        block: |
          apiVersion: v1
          kind: Config
          clusters:
          - cluster:
              server: https://{{ master_nodes[0].ip }}:6443
              certificate-authority-data: {{ ca_cert }}
            name: kubernetes
          contexts:
          - context:
              cluster: kubernetes
              user: kubernetes-admin
            name: kubernetes-admin@kubernetes
          current-context: kubernetes-admin@kubernetes
          preferences: {}
          users:
          - name: kubernetes-admin
            user:
              client-certificate-data: {{ client_cert }}
              client-key-data: {{ client_key }}
      when: inventory_hostname == master_nodes[0].name

    - name: Deploy network plugin
      kubernetes.core.k8s:
        state: present
        definition: "{{ lookup('file', 'flannel.yml') }}"
      when: inventory_hostname == master_nodes[0].name
```

#### 2. Resource Deployment Solution

```yaml
# kubernetes_deployment.yml
---
- name: Deploy application to Kubernetes
  hosts: localhost
  gather_facts: false
  vars:
    app_name: myapp
    app_version: 1.0.0
    namespace: production
    replicas: 3
    resources:
      requests:
        cpu: "100m"
        memory: "128Mi"
      limits:
        cpu: "500m"
        memory: "512Mi"

  tasks:
    - name: Create namespace
      kubernetes.core.k8s:
        name: "{{ namespace }}"
        api_version: v1
        kind: Namespace
        state: present

    - name: Deploy application
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: apps/v1
          kind: Deployment
          metadata:
            name: "{{ app_name }}"
            namespace: "{{ namespace }}"
          spec:
            replicas: "{{ replicas }}"
            selector:
              matchLabels:
                app: "{{ app_name }}"
            template:
              metadata:
                labels:
                  app: "{{ app_name }}"
              spec:
                containers:
                - name: "{{ app_name }}"
                  image: "{{ app_name }}:{{ app_version }}"
                  ports:
                  - containerPort: 80
                  resources: "{{ resources }}"
                  readinessProbe:
                    httpGet:
                      path: /health
                      port: 80
                    initialDelaySeconds: 5
                    periodSeconds: 10
                  livenessProbe:
                    httpGet:
                      path: /health
                      port: 80
                    initialDelaySeconds: 15
                    periodSeconds: 20

    - name: Create service
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: v1
          kind: Service
          metadata:
            name: "{{ app_name }}"
            namespace: "{{ namespace }}"
          spec:
            selector:
              app: "{{ app_name }}"
            ports:
            - port: 80
              targetPort: 80
            type: LoadBalancer

    - name: Monitor deployment
      kubernetes.core.k8s_info:
        kind: Deployment
        name: "{{ app_name }}"
        namespace: "{{ namespace }}"
      register: deployment_status
      until: deployment_status.resources[0].status.availableReplicas | int == replicas
      retries: 30
      delay: 10
```

#### 3. Service Management Solution

```yaml
# kubernetes_service.yml
---
- name: Manage Kubernetes services
  hosts: localhost
  gather_facts: false
  vars:
    services:
      - name: web
        port: 80
        target_port: 80
        type: LoadBalancer
      - name: api
        port: 8080
        target_port: 8080
        type: ClusterIP
      - name: db
        port: 3306
        target_port: 3306
        type: ClusterIP

  tasks:
    - name: Create services
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: v1
          kind: Service
          metadata:
            name: "{{ item.name }}"
            namespace: production
          spec:
            selector:
              app: "{{ item.name }}"
            ports:
            - port: "{{ item.port }}"
              targetPort: "{{ item.target_port }}"
            type: "{{ item.type }}"
      loop: "{{ services }}"

    - name: Configure service monitoring
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: monitoring.coreos.com/v1
          kind: ServiceMonitor
          metadata:
            name: "{{ item.name }}"
            namespace: monitoring
          spec:
            selector:
              matchLabels:
                app: "{{ item.name }}"
            endpoints:
            - port: http
              interval: 15s
      loop: "{{ services }}"

    - name: Configure load balancing
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: networking.k8s.io/v1
          kind: Ingress
          metadata:
            name: "{{ item.name }}"
            namespace: production
            annotations:
              kubernetes.io/ingress.class: nginx
              nginx.ingress.kubernetes.io/ssl-redirect: "true"
          spec:
            rules:
            - host: "{{ item.name }}.example.com"
              http:
                paths:
                - path: /
                  pathType: Prefix
                  backend:
                    service:
                      name: "{{ item.name }}"
                      port:
                        number: "{{ item.port }}"
      loop: "{{ services }}"
      when: item.type == "LoadBalancer"
```

#### 4. Configuration Management Solution

```yaml
# kubernetes_config.yml
---
- name: Manage Kubernetes configurations
  hosts: localhost
  gather_facts: false
  vars:
    configs:
      - name: app-config
        data:
          DATABASE_URL: "mysql://user:pass@db:3306/db"
          API_KEY: "{{ vault_api_key }}"
          LOG_LEVEL: "info"
      - name: db-config
        data:
          MYSQL_ROOT_PASSWORD: "{{ vault_db_password }}"
          MYSQL_DATABASE: "myapp"
          MYSQL_USER: "user"
          MYSQL_PASSWORD: "{{ vault_db_user_password }}"

  tasks:
    - name: Create ConfigMaps
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: v1
          kind: ConfigMap
          metadata:
            name: "{{ item.name }}"
            namespace: production
          data: "{{ item.data }}"
      loop: "{{ configs }}"

    - name: Create secrets
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: v1
          kind: Secret
          metadata:
            name: "{{ item.name }}-secrets"
            namespace: production
          type: Opaque
          data: "{{ item.data | to_json | b64encode }}"
      loop: "{{ configs }}"

    - name: Update deployments with configs
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: apps/v1
          kind: Deployment
          metadata:
            name: "{{ item.name }}"
            namespace: production
          spec:
            template:
              spec:
                containers:
                - name: "{{ item.name }}"
                  envFrom:
                  - configMapRef:
                      name: "{{ item.name }}"
                  - secretRef:
                      name: "{{ item.name }}-secrets"
      loop: "{{ configs }}"
```

#### 5. Scaling Operations Solution

```yaml
# kubernetes_scaling.yml
---
- name: Manage Kubernetes scaling
  hosts: localhost
  gather_facts: false
  vars:
    applications:
      - name: web
        min_replicas: 2
        max_replicas: 10
        target_cpu: 80
      - name: api
        min_replicas: 3
        max_replicas: 15
        target_cpu: 70
      - name: worker
        min_replicas: 1
        max_replicas: 5
        target_cpu: 60

  tasks:
    - name: Configure Horizontal Pod Autoscaling
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: autoscaling/v2
          kind: HorizontalPodAutoscaler
          metadata:
            name: "{{ item.name }}"
            namespace: production
          spec:
            scaleTargetRef:
              apiVersion: apps/v1
              kind: Deployment
              name: "{{ item.name }}"
            minReplicas: "{{ item.min_replicas }}"
            maxReplicas: "{{ item.max_replicas }}"
            metrics:
            - type: Resource
              resource:
                name: cpu
                target:
                  type: Utilization
                  averageUtilization: "{{ item.target_cpu }}"
      loop: "{{ applications }}"

    - name: Configure resource limits
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: apps/v1
          kind: Deployment
          metadata:
            name: "{{ item.name }}"
            namespace: production
          spec:
            template:
              spec:
                containers:
                - name: "{{ item.name }}"
                  resources:
                    requests:
                      cpu: "100m"
                      memory: "128Mi"
                    limits:
                      cpu: "500m"
                      memory: "512Mi"
      loop: "{{ applications }}"

    - name: Configure node autoscaling
      kubernetes.core.k8s:
        state: present
        definition:
          apiVersion: autoscaling/v1
          kind: ClusterAutoscaler
          metadata:
            name: default
          spec:
            scaleDown:
              enabled: true
              delayAfterAdd: 5m
              delayAfterDelete: 5m
              delayAfterFailure: 5m
              unneededTime: 5m
            scaleUp:
              enabled: true
              delayAfterFailure: 3m
              unneededTime: 3m
```

## Best Practices

1. **Container Management**
   - Use specific version tags for images
   - Implement health checks
   - Use resource limits
   - Implement proper logging

2. **Security**
   - Use non-root users
   - Implement security contexts
   - Use secrets for sensitive data
   - Regular security updates

3. **Performance**
   - Monitor resource usage
   - Implement proper scaling
   - Use caching effectively
   - Optimize image sizes

4. **Maintenance**
   - Regular updates
   - Backup procedures
   - Monitoring and alerting
   - Documentation

## Conclusion

Ansible provides powerful capabilities for managing both Docker and Kubernetes environments. By following best practices and implementing proper security measures, you can create robust and maintainable container infrastructures.

Remember to:
- Always use version control for your playbooks
- Implement proper error handling
- Follow security best practices
- Monitor and maintain your container environments
- Keep documentation up to date 



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
