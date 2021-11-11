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

usermod -aG docker vagrant

docker version

# ##################################################################################################################
# INSTALL DOCKER-COMPOSE - https://docs.docker.com/compose/install/
# ##################################################################################################################
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

docker-compose version

# ##################################################################################################################
# INSTALL NGINX AND CONFIGURE SSL
# ##################################################################################################################
apt-get -y install nginx

rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default

# OpenSSL 1.1.1
# https://docs.oracle.com/cd/E24191_01/common/tutorials/authz_cert_attributes.html
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout server.key -out server.crt -subj '/C=BR/L=Foz do Iguacu/O=Uniamerica/OU=Eng/CN=example' \
  -addext 'subjectAltName=DNS:example.com,DNS:www.example.com,IP:192.168.10.50,IP:127.0.0.1'

openssl x509 -noout -text -in server.crt

mv server.* /etc/nginx/conf.d/