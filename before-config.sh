#!/bin/bash
#define /etc/hosts if need in the master node

# the script should be run manually in every node
#ensure there is a common user name in every node
sudo useradd xxxx
sudo passwd xxxx

#Add a user into sudo list
sudo visudo
#add the following information
xxxx    ALL=(ALL)       NOPASSWD: ALL
#make sure "Defaults    requiretty" are commented
#Defaults    requiretty

#Install expect
sudo yum install -y expect



