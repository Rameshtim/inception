
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
docker build -t getting-started .<br>