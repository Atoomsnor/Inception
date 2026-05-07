*This project has been created as part of the 42 curriculum by roversch.*

## Description
This project aims to broaden knowledge of system administration by using Docker.
It virtualizes several Docker images, creating them in a personal virtual machine.

## Services
The stack runs three containers over a private Docker network (`inception`):
- **nginx**: HTTPS reverse proxy, the only entry point (port 443)
- **wordpress**: php-fpm application server (port 9000)
- **mariadb**: database backend for WordPress (port 3306)

## Docker & Design choices
Docker is used to run each service in an isolated container, replacing the need for full virtual machines.

### Virtual Machines vs Docker
VMs emulate an entire OS, making them heavy and slow to start.
Docker containers share the host kernel, making them lightweight and fast.

### Secrets vs Environment Variables
Environment variables are simple but visible in plain text.
Secrets are more secure as they are stored separately and only mounted when needed.

### Docker Network vs Host Network
Docker network creates a private internal network between containers, whereas host network gives containers direct access to the host's network, removing isolation.

### Docker Volumes vs Bind Mounts
Docker volumes are managed by Docker and stored internally.
Bind mounts allow direct mounting to a host directory, giving more control over where data is stored.

## Instructions

### Prerequisites
- Docker Engine 24+ and Docker Compose v2+
- Make and OpenSSL
- A user with `sudo` privileges

### Configuration
- A test `.env` file  with all required variables (default `~/Desktop/env_test`)
- Add domain to `/etc/hosts`:
 ```bash
  sudo sh -c 'echo "127.0.0.1 roversch.42.fr" >> /etc/hosts'
  ```
- For developer documentation see `DEV_DOC.md`

### Build and launch
- Import the git repository
```bash
git clone https://github.com/Atoomsnor/Inception.git Inception
cd Inception/
```
- Make and start the executable
```bash
make all       # generate certs, create data dirs, build and start containers
make down      # stop and remove containers
make fclean    # stop, remove containers and volumes
make re        # clean and rebuild
```
Access the website with: `https://roversch.42.fr`

Or for admin access: `https://roversch.42.fr/wp-admin`

## Resources

### Docker
- [Docker cmd cheatsheet](https://github.com/sidpalas/devops-directive-docker-course/blob/main/10-interacting-with-docker-objects/README.md)
- [Docker volumes](https://docs.docker.com/engine/storage/volumes/)
- [Docker networking](https://docs.docker.com/compose/how-tos/networking/)
- [Running commands inside container](https://docs.docker.com/reference/cli/docker/container/exec/)
- [Docker Volume VS Bind Mount](https://www.geeksforgeeks.org/devops/docker-volume-vs-bind-mount/)
- [Debian image](https://hub.docker.com/layers/library/debian/bookworm-slim/images/sha256-993f5593466f84c9200e3e877ab5902dfc0e4a792f291c25c365dbe89833411f)

### MariaDB
- [MariaDB basics guide](https://mariadb.com/docs/server/mariadb-quickstart-guides/basics-guide)
- [MariaDB Create users](https://utho.com/docs/database/mariadb/how-to-create-a-user-and-grantprevileges-on-a-specific-ip/)

### WordPress
- [Install WordPress](https://make.wordpress.org/cli/handbook/guides/installing/)
- [Configuration the Listen Directive](https://serversforhackers.com/c/php-fpm-configuration-the-listen-directive)
- [Config settings](https://developer.wordpress.org/apis/wp-config-php/)

### Nginx
- [Nginx example config](https://nginx.org/en/docs/http/configuring_https_servers.html)
- [SSL certificate settings](https://www.ibm.com/docs/en/ibm-mq/7.5.0?topic=certificates-distinguished-names)
- [Nginx config for WP](https://tundedamian.medium.com/day-20-of-100-days-of-devops-deploying-a-php-application-with-nginx-and-php-fpm-ac9e0111d88a)
- [Nginx CSS fix](https://stackoverflow.com/questions/10075304/nginx-fails-to-load-css-files)

### AI
- Claude.ai has been used throughout for putting me in the right direction.
- Claude.ai has been used to solve script related problems if no answer was found.
- Claude.ai has been used to spellcheck this README.md