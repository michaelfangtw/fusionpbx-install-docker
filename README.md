* A  fusionpbx docker that  base on https://github.com/fusionpbx/fusionpbx-install.sh
** Including below services that in Dockerfile
```
iptables
sngrep
fusionpbx
php
nginx
postgres
freeswitch
fail2ban

```
** 1.modify  config.sh and chown
```
chown 33:33 config -R

```
** 2.build image
```
docker build -t fusionpbx-docker:1.0 .
```
** 3. modify docker-copmpose.yaml
```
services:
  pbx:
    # Build the image from the local Dockerfile so the local modified installer
    # if you want to build by your self
    # build:
    #  context: .

    # user docker hub 
    image: michaelfangtw/fusionpbx-docker:1.0

    # Use host networking to allow the container to access all host ports.
    # This is necessary for the large RTP port range.
    network_mode: "host"

    # Set the container name for eaml: line 7: did not find expected key
    container_name: fusionpbx

    # Restart the container automatically if it fails or if the host reboots
    restart: always
    privileged: true

    # Load environment variables from a .env file at the compose root
    #env_file:
    #  - .env

    # Persist fusionpbx webapp, configs and FreeSWITCH autoload configs on the host
    volumes:
      - ./config/fusionpbx:/etc/fusionpbx

    #
    # Maps to the /usr/sbin/init command. This is the main process for the container.
    entrypoint: ["/usr/sbin/init"]

```
** step 4.
```
docker compose up -d
```
** software installed 
```
- fusionpbx:5.4.7 
- freeswitch: 1.10.12
- os:ubuntu:24.04
```
** default login id/pass
```
http://localhost
id:amdin@localhost
pass=password
```
** if you cannot login failed, you can reset admin/pass
```

- if above steps failed ,you can reset admin password 
```
docker exec -it fusionpbx /bin/bash
mv /etc/fusionpbx/config.conf to config.conf.old
```
# postgres db id/pass (DO NOT CHANGE)
```
 db host:localhost 
 db user:fusionpbx
 db password:password
```

# reset your new web admin
```
 -user: admin
 -password: password
```
```
