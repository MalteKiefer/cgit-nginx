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

