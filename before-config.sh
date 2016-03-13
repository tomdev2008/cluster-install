#!/bin/bash
#define /etc/hosts if need in the master node

# the script should be run manually in every node
#ensure there is a common user name in every node
sudo useradd xxxx
sudo passwd xxxx

#login & key setup
if [ ! -f ~/.ssh/id_rsa ] ; then ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa;fi; cat ~/.ssh/id_rsa.pub
echo ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIB5VkViP9huenvC8oG54F06DQn4dszbAQTO/8eAWWFI5CogeLC58MNPQ4LoqPy0Nfss1UmR7mGAq54E1C5f3R9giW3EeDPbHoP9oAiFx5iB+NM0stg4yQnC2YSTOi5Gq54ZQz1VySAkKlpSxBs2HAxnmOhQA3cebNaUrXDLFH/GTw== xu63 >>  ~/.ssh/authorized_keys
chmod  600 ~/.ssh/authorized_keys

#Add a user into sudo list(增加用户到sudo列表中)
visudo
grid    ALL=(ALL)       NOPASSWD: ALL
#make sure: "Default requiretty" is commented as below
#Default requiretty

#关闭防火墙
sudo  service iptables stop
sudo  service iptables save
sudo  chkconfig iptables off
sudo  service ip6tables stop
sudo  service ip6tables save
sudo  chkconfig ip6tables off

#tigervnc
sudo yum install tigervnc  -y
sudo yum install tigervnc-server -y
vncserver :1
vncserver -list
  
#git clone  
sudo yum install git 
git config --global user.name "eipi10"
git config --global user.email "eipi10@qq.com"
cat ~/.ssh/id_rsa.pub  #copy the key to github
git clone git@github.com:xuxiangwen/cluster-install.git

#push & pull
git push origin master
git pull origin master


#Add a user into sudo list
sudo visudo
#add the following information
xxxx    ALL=(ALL)       NOPASSWD: ALL
#make sure "Defaults    requiretty" are commented
#Defaults    requiretty

#Install expect
sudo yum install -y expect



