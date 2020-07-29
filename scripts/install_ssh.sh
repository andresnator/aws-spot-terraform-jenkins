#!/bin/bash

########################################################
##### USE THIS FILE IF YOU LAUNCHED AMAZON LINUX 2 #####
########################################################




#********************************************************************************
#********************************************************************************
#********************************************************************************

echo "******************** Installing tools"
sudo yum -y update
sudo yum -y install epel-release
sudo yum -y install unzip \
                    jq \
                    dnsmasq \
                    ca-certificates \
                    curl \
                    msmtp \
                    lsyncd \
                    net-tools

#********************************************************************************
#********************************************************************************
#********************************************************************************

echo "******************** Installing Docker "
sudo yum -y update

##SET UP THE REPOSITORY
sudo yum install -y yum-utils
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

##INSTALL DOCKER ENGINE
sudo yum install -y docker-ce docker-ce-cli containerd.io
echo "******************** Adding non-root User to Docker's group"
sudo usermod -aG docker ${USER}
#********************************************************************************
#********************************************************************************
#********************************************************************************


echo "******************** Docker start docker"
sudo systemctl start docker


echo "******************** Install Docker Compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

echo "******************** End"
