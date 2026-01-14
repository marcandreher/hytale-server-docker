![Docker Pulls](https://img.shields.io/docker/pulls/marcandreher/hytale-server)
![Docker Image Size](https://img.shields.io/docker/image-size/marcandreher/hytale-server/latest)
![Docker Stars](https://img.shields.io/docker/stars/marcandreher/hytale-server)
[![GitHub Repo](https://img.shields.io/badge/View%20on-GitHub-black?logo=github)](
https://github.com/marcandreher/hytale-server-docker
)
[![GitHub stars](https://img.shields.io/github/stars/marcandreher/hytale-server-docker?style=social)](
https://github.com/marcandreher/hytale-server-docker
)

Hytale Docker Container with optimized settings

Running the server:

Simple:
```
docker run -it --rm \
  -p 5520:5520/udp \
  -v $(pwd)/:/hytale \
  marcandreher/hytale-server:latest
```

Advanced:
```
docker run -it --rm \
  -p 5520:5520/udp \
  -v $(pwd)/:/hytale \
  -e HYTALE_AUTH_MODE=authenticated \
  -e HYTALE_BIND=0.0.0.0:5520 \
  -e HYTALE_BACKUP=true \
  -e HYTALE_BACKUP_DIR=/hytale/backups \
  -e HYTALE_BACKUP_FREQUENCY=60 \
  marcandreher/hytale-server:latest
```
