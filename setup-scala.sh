#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.sh

$scriptpath/software_untar.sh $scala_home $scala_folder $scala_jar

echo 'set /etc/profile.d/scala.sh'
echo export SCALA_HOME=$scala_home  > $targetpath/scala.sh
echo export PATH='$SCALA_HOME/bin:$PATH' >> $targetpath/scala.sh
sudo mv $targetpath/scala.sh /etc/profile.d

$scriptpath/command-with-text.sh " ls -l $scala_home"
$scriptpath/command-with-text.sh " ls -l $aapath | grep $scala_folder"
$scriptpath/command-with-text.sh " cat /etc/profile.d/scala.sh"

