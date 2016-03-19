#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.`hostname`

$scriptpath/software-untar.sh $python_home $python_folder $python_jar

echo 'set /etc/profile.d/python.sh'
echo export python_HOME=$python_home  > $targetpath/python.sh
echo export PATH='$python_HOME/bin:$PATH' >> $targetpath/python.sh
sudo mv $targetpath/python.sh /etc/profile.d

$scriptpath/command-with-text.sh "ls -l $python_home"
$scriptpath/command-with-text.sh "ls -l $aapath | grep $python_folder"
$scriptpath/command-with-text.sh "cat /etc/profile.d/python.sh"

