# Run spark in Docker Container
This official docker image will create a container of ubuntu machine with Java17, scala2.12, spark3.5.4 and python3 with pip package manager in it

> github/apache/spark-docker
[Official Docker file](https://github.com/apache/spark-docker/blob/6b917ced4279dd7b3a33a81a08db37b3f27e037b/3.5.4/scala2.12-java17-python3-ubuntu/Dockerfile)

> [!WARNING]
> This Dockerfile is under Apache License, Version 2.0, I am using its code for development purpose only by doing some minor changes in it as per my requirement like including jupyter notebook and creating entry point to the container. [Run jupyter Notebook inside spark container](https://medium.com/@sanjeets1900/setting-up-apache-spark-from-scratch-in-a-docker-container-a-step-by-step-guide-2c009c98f2a7)


To `create and start the conatiner`, execute below command from you currenty directory where Dockerfile is present

#### Create a docker image from Dockerfile
```
cd /home/username/learning/spark
docker build -t dev-spark .
```
> [!NOTE]
> Need to run the build image command with root user permissions


#### Start the container from the image created above
```
hostfolder="$(pwd)"
dockerfolder="/home/sparkuser/app"

docker run --name my-spark-container \
-p 4040:4040 -p 4041:4041 \
-v ${hostfolder}/app:${dockerfolder} -v ${hostfolder}/event_logs:/home/spark/event_logs \
-v /home/username/data:/home/sparkuser/data \
dev-spark jupyter
```

#### Verify if the packages are installed successful

```
spark-submit --version
java --version
python3 --version
```

Refer this 
[Quick start](https://spark.apache.org/docs/latest/quick-start.html)
from spark official documentation to get started with spark

> [!TIP]
> We can use this spark container with different spark APIs like Python, Scala and Java, note here R API is not supported in this container

> To open Spark Interactive shell of
<ins> Python </ins> : `pyspark`, 
<ins> Scala </ins> : `spark-shell`

> To run application of Java, Python or Scala by spark
<ins> Java </ins> : `spark-submit`

**Access the Spark UI**
>Once the container is running, you can access the Spark UI by navigating to `http://localhost:4040` in your web browser.
>Access Jupyter notebook at following URL `http://localhost:4041`

#### To restart the stopped container
```
docker restart my-spark-container
```

#### Stop the container
```
docker stop my-spark-container
docker container rm my-spark-container
```

#### Remove the docker image
```
docker image rm dev-spark
```