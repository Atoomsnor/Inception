## Services
The stack runs three containers over a private Docker network (`Inception`):
- **Nginx**: HTTPS reverse proxy
- **Wordpress**: php-fpm application server
- **Mariadb**: database server

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
make re        # clean and rebuild
```

## Access
- Website: `https://roversch.42.fr`

## Credentials
- All credentials are stored in `.env` (default `~/Desktop/env_test`) 

## Health check
```bash
docker ps                          # all three containers should show "healthy" or "running"
docker logs mariadb                # check for "ready for connections"
docker logs wordpress              # check for "WordPress installed successfully"
docker logs nginx                  # check for no errors
```