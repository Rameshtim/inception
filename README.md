
# inception

## Docker commands


### Install docker in computer

1.  Add Docker's official GPG key:- <br>
sudo apt-get update <br>
sudo apt-get install ca-certificates curl<br>
sudo install -m 0755 -d /etc/apt/keyrings<br>
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc<br>
sudo chmod a+r /etc/apt/keyrings/docker.asc<br>

2.  Add the repository to Apt sources: <br>
echo \<br>
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \<br>
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \<br>
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null<br>
sudo apt-get update<br>

3.  Install the latest version <br>
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin<br>

4.  Verify the installation <br>
    sudo docker run hello-world<br>

5. After installation to use docker without sudo  <br>
    sudo groupadd docker<br>
    sudo usermod -aG docker $USER <br>

    -- check with <br>
    newgrp docker<br>
    docker run hello-world<br>


### Build a docker image
	docker build -t "Name of the container" .

### Run a Container detached
	docker run -dp 127.0.0.1:3000:3000 "Name of the container"

### Run a container
	docker run -it -p 443:443 "name of cont"

### List Containers
	docker ps

### Stop the container
	docker stop "the-container-id" 
	docker rm "the-container-id"
	or 
	docker rm -f "the-container-id"

### List docker image
	docker image ls

### Delete Docker Image


### Pushing in Dockerhub
	a.	docker login -u "username"
	b.	docker tag getting-started username/getting-started "give a name to image using tag"
	c.	docker push username/getting-started
	
### Connect to the DataBase
	docker exec -it "container-id" mysql -u root -p

### Access terminal after lunching docker
	docker run -it "imagename"
