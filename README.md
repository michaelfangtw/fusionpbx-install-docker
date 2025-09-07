# FusionPBX Docker

This project provides a Docker setup for FusionPBX, based on the official installer script from [fusionpbx-install.sh](https://github.com/fusionpbx/fusionpbx-install.sh).

It simplifies the deployment of a full-featured FusionPBX instance in a containerized environment.

## Included Services

The Docker image comes pre-installed with the following services:
- FusionPBX
- FreeSWITCH
- Nginx
- PHP
- PostgreSQL
- iptables
- sngrep
- Fail2ban

## Prerequisites

Before you begin, ensure you have the following installed on your host machine:
- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Getting Started

Follow these steps to configure, build, and run your FusionPBX container.

### 1. Configuration

First, you need to set up the environment variables for your instance.

**A. Create Environment File:**

Copy the sample environment file to a new `.env` file:
```bash
cp .env.sample .env
```

**B. Set Passwords:**

Edit the `.env` file and replace the placeholder values with strong, secure passwords:

```dotenv
# .env
SYSTEM_PASSWORD=YOUR_SECURE_SYSTEM_PASSWORD
DATABASE_PASSWORD=YOUR_SECURE_DATABASE_PASSWORD
```

**C. Set Directory Permissions:**

The container needs to write configuration files to a mounted volume on the host. Grant the correct permissions to the `config` directory:
```bash
sudo chown -R 33:33 config
```
*This is necessary because the user running PHP inside the container (user ID 33) needs to have write access to the `/etc/fusionpbx` directory, which is mapped to `./config/fusionpbx` on your host.*

**D. (Optional) Advanced Configuration:**

For advanced setup, you can modify the `config.sh` file to change settings for FusionPBX, FreeSWITCH, the database, and more.

### 2. Build the Docker Image

Next, build the Docker image using the provided Dockerfile. This process can take some time as it compiles FreeSWITCH from the source.

```bash
docker build -t fusionpbx-install-docker:1.0 .
```
Alternatively, you can use the provided build script:
```bash
./build.sh
```

### 3. Run the Container

The `docker-compose.yaml` file is configured to run the FusionPBX instance.

**A. Enable Environment File in Docker Compose:**

Before running, you need to enable the use of your `.env` file. Open `docker-compose.yaml` and uncomment the `env_file` section:

```yaml
# docker-compose.yaml

services:
  pbx:
    # ... (other settings) ...

    # Load environment variables from a .env file at the compose root
    env_file:
      - .env

    # ... (other settings) ...
```

**B. Start the Service:**

Start the container in detached mode using Docker Compose:
```bash
docker compose up -d
```
You can also use the provided helper script, which will stop any existing container and start a new one:
```bash
./compose.sh
```

### 4. Access FusionPBX

Once the container is running, you can access the FusionPBX web interface by navigating to your host machine's IP address in a web browser.

- **URL:** `http://<your-host-ip>`
- **Username:** `admin` (or as set in `config.sh`)
- **Password:** The `SYSTEM_PASSWORD` you set in the `.env` file.

## Data Persistence

The FusionPBX configuration is persisted on the host machine in the `./config/fusionpbx` directory. This is achieved through a volume mount defined in `docker-compose.yaml`.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.