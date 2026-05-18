# Docker Fundamentals Course Lab

The idea of this lab is to create a playground environment while we explore the gist of docker and docker compose

### Pre Requisites 
- Docker installed on your system
    - In case you do not have it installed please check with the documentation

```sh
curl -L get.docker.com |sudo bash 
```
- Internet Access so we can download docker base images
    - In case no internet connection available, then registry with `rockylinux:9.3`, `debian:12` and `python:3.11` images

- Reading glasses, in case you don't know what RTFM means

### How to start the lab ?

Lab is largely based on `docker compose` and we need to run its file to set it up:

```sh
docker compose up -d
```
> Note: docker added `compose` plugin to docker package since version 25 and there is no need to install the external binary for it.

Once the image build is done and docker compose goes `up`, you need to login to `ansible-host` and change directory to default users home directory and there will be 12 chapters of the course.

### How to learn ?

The whole project is a learning material in which you can shallow dive in to ansible and ansible-playbook basics.
just go from 1 to 12 and if something is not clear, either contact me (silent-mobius aka zero-pytagoras aka Alex M. Schapelle -> alex@vaiolabs.com) or open a issue in gitlab repository and once I'll see it, I'll handle it.

### Troubleshooting

If it does not work:

- open issue on gitlab with print-screen and detailed description
- send mail with print-screen and detailed description
- send raven with letter of explanation
- pray to omnisaya and summon adeptus mechanicus for aid

