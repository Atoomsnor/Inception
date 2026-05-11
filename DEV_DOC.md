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
show tables;                     # shows created SELECT options
SELECT * from wp_comments \G;    # show organised comments
SELECT * from wp_users \G;       # show created users
```

## Port swaps
### Nginx <-> WWW
`.env` domain name to have `:"port"` behind it
`docker-compose.yml` change leftside nginx port `"port":433`

### Nginx <-> WP+PHP
`/wordpress/tools/wp_script.sh` change the `sed` line `0.0.0.0:"port"` 
`/wordpress/dockerfile` change `EXPOSE	"port"`
`/nginx/conf/nginx.conf` change `fastcgi_pass wordpress:"port";`

### WP+PHP <-> MariaDB
`/wordpress/tools/wp_script.sh` add port `--dbhost=mariadb:"port"`
`/mariadb/conf/50-server.conf` add line `port = "port"`

## Data storage

- Volumes are stored at `~/roversch/data`
- Delete the database with `make fclean`