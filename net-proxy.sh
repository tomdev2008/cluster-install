#!/bin/bash
#set net proxy 
#sudo -s
if ! grep -q -i '^proxy=http://web-proxy.atl.hp.com:8080$' /etc/yum.conf; then echo proxy=http://web-proxy.atl.hp.com:8080 >> /etc/yum.conf; fi
if ! grep -q -i '^http_proxy=http://web-proxy.atl.hp.com:8080$' /etc/profile ; then echo http_proxy=http://web-proxy.atl.hp.com:8080 >> /etc/profile ; fi
if ! grep -q -i '^https_proxy=http://web-proxy.atl.hp.com:8080$' /etc/profile ; then echo https_proxy=http://web-proxy.atl.hp.com:8080 >> /etc/profile ; fi
if ! grep -q -i '^http_proxy=http://web-proxy.atl.hp.com:8080$' /etc/wgetrc ; then echo http_proxy=http://web-proxy.atl.hp.com:8080 >> /etc/wgetrc ; fi
source /etc/profile
#exit

