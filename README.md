
# inception

## Docker commands

### Install docker in computer

1.  Add Docker's official GPG key:- <br>
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

2.  Add the repository to Apt sources: <br>
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

3.  Install the latest version <br>
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

4.  Verify the installation <br>
    sudo docker run hello-world

5. After installation to use docker without sudo  <br>
    sudo groupadd docker
    sudo usermod -aG docker $USER <br>

    -- check with <br>
    newgrp docker
    docker run hello-world


### Build a docker image
docker build -t getting-started .