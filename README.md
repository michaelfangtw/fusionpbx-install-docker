# FusionPBX Docker
Base OS: Ubuntu 24.04/FusionPBX: 5.4.7/FreeSWITCH: 1.10.12/PHP: 8.3/PostgreSQL: 16


A Docker implementation of FusionPBX based on the official [fusionpbx-install.sh](https://github.com/fusionpbx/fusionpbx-install.sh) installer.
## � Overview

This Docker container provides a complete, ready-to-use FusionPBX installation with all necessary components pre-configured. It's designed to simplify the deployment of a full-featured PBX system using Docker containers.

**Key Features:**
- 🚀 One-command deployment
- 🔧 Pre-configured services
- 💾 Persistent data storage
- 🌐 Host networking for RTP
- 🔒 Security with fail2ban

## �📋 Included Services

The Docker image includes the following services:

- **iptables** - Firewall management
- **sngrep** - SIP packet capture tool
- **fusionpbx** - Web-based PBX system
- **php** - PHP runtime
- **nginx** - Web server
- **postgres** - Database server
- **freeswitch** - Voice over IP platform
- **fail2ban** - Intrusion prevention system

## 🚀 Quick Start

### 1. Configure Permissions

First, set the proper ownership for the config directory:

```bash
chown 33:33 config -R
```

### 2. Build the Image (Optional)

If you want to build the image locally:

```bash
docker build -t fusionpbx-docker:1.0 .
```

**Or use the pre-built image from Docker Hub:**

```bash
docker pull michaelfangtw/fusionpbx-docker:1.0
```

- 📦 **Docker Hub**: [michaelfangtw/fusionpbx-docker](https://hub.docker.com/repository/docker/michaelfangtw/fusionpbx-docker)
- 🏷️ **Latest Tag**: `michaelfangtw/fusionpbx-docker:1.0`

### 3. Configure Docker Compose

The `docker-compose.yaml` file is already configured. You can use either:

- **Pre-built image** (default): `michaelfangtw/fusionpbx-docker:1.0`
- **Local build**: Uncomment the `build` section in the compose file

```yaml
services:
  pbx:
    # Use pre-built image from Docker Hub
    image: michaelfangtw/fusionpbx-docker:1.0
    
    # Or build locally (uncomment to use)
    # build:
    #   context: .

    # Host networking for RTP port range
    network_mode: "host"
    container_name: fusionpbx
    restart: always
    privileged: true

    # Persist configuration
    volumes:
      - ./config/fusionpbx:/etc/fusionpbx

    entrypoint: ["/usr/sbin/init"]
```

### 4. Start the Container

```bash
docker compose up -d
```

## 📊 Software Versions

- **Base OS**: Ubuntu 24.04
- **FusionPBX**: 5.4.7
- **FreeSWITCH**: 1.10.12
- **PHP**: 8.3
- **PostgreSQL**: 16
- **Nginx**: Latest
- **Fail2Ban**: Latest

## 🔐 Default Credentials

### Web Interface

- **URL**: http://localhost
- **Username**: admin@localhost
- **Password**: password

### Database (PostgreSQL)

⚠️ **DO NOT CHANGE** - Required for proper operation:

- **Host**: localhost
- **User**: fusionpbx
- **Password**: password

## 🔧 Troubleshooting

### Reset Admin Credentials

If you cannot log in to the web interface:

1. Access the container:
   ```bash
   docker exec -it fusionpbx /bin/bash
   ```

2. Backup and reset the config:
   ```bash
   mv /etc/fusionpbx/config.conf /etc/fusionpbx/config.conf.old
   ```

3. Set database configuration:
   - **Host**: localhost
   - **Username**: fusionpbx
   - **Password**: password *(set in .env or config.sh)*

4. Reset admin credentials:
   - **Username**: admin
   - **Password**: password

### Database Connection Issues

If you encounter database-related login failures, re-run the installation steps inside the container:

1. Access the container:
   ```bash
   docker exec -it fusionpbx /bin/bash
   ```

2. Navigate to the resources directory:
   ```bash
   cd /usr/src/fusionpbx-install.sh/ubuntu/resources
   ```

3. Recreate the database:
   ```bash
   ./postgresql.sh    # Create database
   ./finish.sh        # Set admin credentials
   ```

### Save Changes to Local Image

If you make changes inside the container and want to save them to a new image:

1. Make your changes inside the container:
   ```bash
   docker exec -it fusionpbx /bin/bash
   # Make your modifications here
   ```

2. Commit the changes to create a new image:
   ```bash
   docker commit fusionpbx fusionpbx-docker:1.0
   docker commit fusionpbx michaelfangtw/fusionpbx-docker:1.0
   ```

   > **Note**: The second command creates an image with the correct username for pushing to Docker Hub.
