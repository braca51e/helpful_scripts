nvidia-docker rmi -f 6ecab9e3b344
nvidia-docker images
#build image
nvidia-docker build -t iamge_name .
#Run image
nvidia-docker run -v $(pwd)/test_dir:/opt/ml -it iamge_name
#Delete images
nvidia-docker rm $(nvidia-docker ps -a -f status=exited -q)
nvidia-docker rmi -f $(nvidia-docker images -a -q)

nvidia-docker run -v $(pwd)/test_dir:/opt/ml -it potato /bin/bash

#Clean everything save space
sudo service docker stop
sudo rm -rf /var/lib/docker
sudo service docker start
docker image prune -a

#Copy file from docker image to host
nvidia-docker cp <containerId>:/file/path/within/container /host/path/target


#Launch open port
nvidia-docker run -v $(pwd)/test_dir:/opt/ml -p 8080:8080 --rm image_name serve

#Remove <none> images dangling 
nvidia-docker images -qf dangling=true | xargs --no-run-if-empty nvidia-docker rmi -f

#One liner to stop / remove all of Docker containers:
nvidia-docker stop $(nvidia-docker ps -a -q)
nvidia-docker rm $(nvidia-docker ps -a -q)
