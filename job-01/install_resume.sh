#!/bin/bash

sudo yum update -y
sudo yum install git httpd wget -y
sudo systemctl start httpd
sudo systemctl enable httpd
# sudo groupadd DevOps
# sudo useradd Serge
sudo yum install unzip  -y  #( apt install wget unzip -y )
wget https://github.com/utrains/static-resume/archive/refs/heads/main.zip
unzip main.zip
cp -r static-resume-main/* /var/www/html/

_path="/var/www/html/assets/img/"
# Concerning profile
mv ${_path}profile-img.jpg  ${_path}profile-img0.jpg

mv /home/ec2-user/website.jpg ${_path}profile-img.jpg

# Concerning background
mv ${_path}hero-bg.jpg   ${_path}hero-bg0.jpg
cp ${_path}profile-img.jpg ${_path}hero-bg.jpg

 

