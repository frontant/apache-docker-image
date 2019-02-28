# Setup Apache Server with Docker

Build custom apache server docker image.

```shell
# build the docker image
docker build -t my-apache .

# run the docker image "my-apache" in the new container "my-apache-app"
docker run -d -p 8080:80 -v $PWD/www:/var/www/html --name my-apache-app my-apache

# monitor apache requests and errors
docker exec -t my-apache-app multitail /var/log/apache2/access.log /var/log/apache2/error.log

# stop the running container
docker stop my-apache-app

# start the stopped container if needed
docker start my-apache-app
```

### Verify the setup

- **Check access to the website** with http://localhost:8080
- **Check server status** with http://localhost:8080/server-status