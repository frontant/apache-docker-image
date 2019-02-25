# Setup Apache Server with Docker

Build custom apache server docker image.

```shell
# build the docker image
docker build -t my-apache .

# run the docker image "my-apache" in the new container "my-apache-app"
docker run -d -p 8080:80 -v $PWD/www:/var/www/html --name my-apache-app my-apache

# stop the running container
docker stop my-apache-app

# start the stopped container if needed
docker start my-apache-app
```

### Verify the setup

Enter http://localhost:8080 in your browser. You schould see the "Hello World" text.