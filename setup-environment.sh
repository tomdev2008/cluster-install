#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
cp $scriptpath/config.`hostname`.sh $scriptpath/config.sh
source $scriptpath/config.sh

previouspath=`pwd`
cd $sourcepath/..
sourcefolder=$(basename $sourcepath)
tar -cf $softwarepath/cluster-install.tar $sourcefolder -C ./software
tar --delete -f $softwarepath/cluster-install.tar   cluster-install/.git
cd $previouspath


for server in "${servers_cwp[@]}"
do
  echo ============server=$server user=$user============
  ssh $user@$server rm -rf $targetpath 
  scp $softwarepath/$sourcefolder.tar $user@$server:$copypath
  ssh $user@$server tar xf $copypath/$sourcefolder.tar -C $copypath
  ssh $user@$server rm -rf $copypath/$sourcefolder.tar

  ssh $user@$server sudo $targetpath/net-proxy.sh
  ssh $user@$server $targetpath/setup-pdsh.sh
done

pdsh -R ssh -w $user@$servers $targetpath/setup-sshpass.sh 

pdcp -R ssh -w $user@$servers ~/.ssh/authorized_keys ~/.ssh/
pdcp -R ssh -w $user@$servers ~/.ssh/known_hosts ~/.ssh/

pdcp -R ssh -w $user@$servers /etc/hosts ~/.ssh/
pdsh -R ssh -w $user@$servers sudo mv ~/.ssh/hosts /etc

pdsh -R ssh -w $user@$servers sudo  service iptables stop
pdsh -R ssh -w $user@$servers sudo  service iptables save
pdsh -R ssh -w $user@$servers sudo  chkconfig iptables off
pdsh -R ssh -w $user@$servers sudo  service ip6tables stop
pdsh -R ssh -w $user@$servers sudo  service ip6tables save
pdsh -R ssh -w $user@$servers sudo  chkconfig ip6tables off

pdsh -R ssh -w $user@$servers sudo mkdir -p $aapath
pdsh -R ssh -w $user@$servers sudo chown -R $user:$user $aapath
pdsh -R ssh -w $user@$servers sudo mkdir -p $aapath1
pdsh -R ssh -w $user@$servers sudo chown -R $user:$user $aapath1

