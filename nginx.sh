#!/bin/bash

sudo apt-get clean && sudo apt-get update

# ##################################################################################################################
# INSTALL DOCKER - DOC: https://docs.docker.com/engine/install/ubuntu/
# ##################################################################################################################
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io -y


# ##################################################################################################################
# INSTALL DOCKER-COMPOSE - https://docs.docker.com/compose/install/
# ##################################################################################################################
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

usermod -aG docker vagrant


# ##################################################################################################################
# INSTALL NGINX
# ##################################################################################################################
sudo apt install nginx openssl -y

## INSTALL SSL
# CREATE DIRECTORY

sudo mkdir /etc/nginx/certificate 
sudo cd /etc/nginx/certificate

# openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out nginx-certificate.crt -keyout nginx.key

# include in server
# listen 443 ssl default_server;
# listen [::]:443 ssl default_server;
# ssl_certificate /etc/nginx/certificate/nginx-certificate.crt;
# ssl_certificate_key /etc/nginx/certificate/nginx.key;