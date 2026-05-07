# Developer documentation

## Environment setup

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

## Build and launch

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

## Useful commands

### Docker
```bash
docker ps                        # list running containers
docker logs mariadb              # view container logs
```

### MariaDB
```bash
docker exec -it mariadb bash     # shell into container
mariadb -u"root" -p"password"    # mariadb access with root
use "database" ($MYSQL_DATABASE) # select correct database
SELECT * from wp_comments \G;    # show organised comments
```

## Data storage

- Volumes are stored at `~/roversch/data`
- Delete the database with `make fclean`