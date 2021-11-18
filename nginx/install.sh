#!/bin/bash

sudo apt-get clean && sudo apt-get update

sudo apt install nginx -y

# remove default confs
rm -f /etc/nginx/sites-available/default
rm -f /etc/nginx/sites-enabled/default

# OpenSSL 1.1.1
# https://docs.oracle.com/cd/E24191_01/common/tutorials/authz_cert_attributes.html
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout server.key -out server.crt -subj '/C=BR/L=Foz do Iguacu/O=Uniamerica/OU=Eng/CN=example' \
  -addext 'subjectAltName=DNS:example.com,DNS:www.example.com,IP:192.168.10.50,IP:127.0.0.1'

openssl x509 -noout -text -in server.crt

mv server.* /etc/nginx/conf.d/

mv /tmp/nginx/ssl.conf /etc/nginx/sites-available/ssl.conf        
ln -s /etc/nginx/sites-available/ssl.conf /etc/nginx/sites-enabled/ssl.conf

sudo service nginx restart