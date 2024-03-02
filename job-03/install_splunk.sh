#!/bin/bash

cd /opt

sudo yum -y install wget

sudo wget -O splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz "https://download.splunk.com/products/splunk/releases/9.0.4.1/linux/splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz"

# Extract the tar file to /opt
sudo tar -zxvf splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz -C /opt

# delete the .tgz file
sudo rm -rf splunk-9.0.4.1-419ad9369127-Linux-x86_64.tgz

cd splunk/bin/

# Start Splunk Enterprise and set up the admin user and password
sudo ./splunk start --accept-license --answer-yes --no-prompt --seed-passwd "abcd1234"

#enable splunk at the startup
sudo ./splunk enable boot-start


