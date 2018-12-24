# Dockerized OBBLM

This is only a dockerized version of [https://github.com/TheNAF/naflm](https://github.com/TheNAF/naflm)

Change the database config in docker-compose.yml before deploy.

Run install.php on a browser and click on "Setup DB for OBBLM"

Connect to the container and remove install.php file or run 

```
docker exec -it <docker-container-id> rm install.php
```