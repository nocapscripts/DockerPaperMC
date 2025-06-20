# DOCKER USAGE


Build image

```
docker build -t papermc .
```

Run container

```
docker run -d -p 25565:25565 -p 2222:22 --name papermc_server papermc
```

