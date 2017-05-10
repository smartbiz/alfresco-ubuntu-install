#!/bin/bash
# -------
# Script to generate self signed ssl certs
#
# Distributed under the Creative Commons Attribution-ShareAlike 3.0 Unported License (CC BY-SA 3.0)
# -------

sudo mkdir -p /etc/nginx/ssl
cd /etc/nginx/ssl
sudo openssl genrsa -des3 -out alfserver.key 1024
sudo openssl req -new -key alfserver.key -out alfserver.csr
sudo cp alfserver.key alfserver.key.org
sudo openssl rsa -in alfserver.key.org -out alfserver.key
sudo openssl x509 -req -days 1825 -in alfserver.csr -signkey alfserver.key -out alfserver.crt
