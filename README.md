# cgit-nginx
A debian based docker for cgit with nginx

***This is only a mirror from my own hosted git server! This is only for issues and Docker Hub***

## Installation
Download this image from the docker hub:
```bash
docker pull beli3ver/cgit-nginx
```
## Usage

#### docker command
You can use this docker with a simple docker command
```bash
docker run -d -p 8181:80 --name cgit -v /srv/git/:/srv/git -v /var/cache/cgit:/var/cache/cgit beli3ver/cgit-nginx:latest
```
### docker-compose command
I created a little docker-compose.yml file that you can use:

```yaml

version: '3'
services:
  app:
    image: beli3ver/cgit-nginx:latest
    container_name: cgit
    restart: always
    ports:
      - 8181:80
    volumes:
      - /srv/git:/srv/git
      - /var/cache/cgit:/var/cache/cgit
      #only needed if you want to replace default files
      #- ./default.conf:/etc/nginx/sites-available/default
      #- ./cgitrc:/etc/cgitrc
```
In combination with traefik it could look like this:
```yaml
version: '3'
services:
  app:
    image: beli3ver/cgit-nginx:latest
    container_name: cgit
    restart: always
    networks:
      - web
    volumes:
      - /srv/git:/srv/git
      - /var/cache/cgit:/var/cache/cgit
    labels:
      - "traefik.enable=true"
      - "traefik.backend=git.example.com"
      - "traefik.frontend=git.example.com"
      - "traefik.docker.network=web"
      - "traefik.frontend.rule=Host:git.example.com"
      - "traefik.port=80"
      - "traefik.frontend.headers.SSLRedirect=true"
      - "traefik.frontend.headers.STSSeconds=315360000"
      - "traefik.frontend.headers.browserXSSFilter=true"
      - "traefik.frontend.headers.contentTypeNosniff=true"
      - "traefik.frontend.headers.forceSTSHeader=true"
      - "traefik.frontend.headers.STSIncludeSubdomains=true"
      - "traefik.frontend.headers.STSPreload=true"
      - "traefik.frontend.headers.frameDeny=true"
networks:
  web:
    external: true
```
