#!/bin/bash
apt update
apt upgrade -y
sudo apt install snapd
apt install apache2 -y
echo "<h1>Hello world This is my Demo Webserver   </h1>" > /var/www/html/index.html
systemctl start apache2
systemctl enable apache2
