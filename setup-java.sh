#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.sh

$scriptpath/software_untar.sh $java_home $java_folder $java_jar

echo 'set /etc/profile.d/java.sh'
echo export JAVA_HOME=$java_home  > $targetpath/java.sh
echo export JRE_HOME='$JAVA_HOME/jre' >> $targetpath/java.sh
echo export CLASSPATH='.:$JAVA_HOME/lib:$JRE_HOME/lib:$JAVA_HOME/lib/tools.jar:$CLASSPATH' >> $targetpath/java.sh
echo export PATH='$JAVA_HOME/bin:$JRE_HOME/bin:$PATH' >> $targetpath/java.sh
sudo mv $targetpath/java.sh /etc/profile.d

$scriptpath/command-with-text.sh "ls -l $java_home"
$scriptpath/command-with-text.sh "ls -l $aapath | grep $java_folder"
$scriptpath/command-with-text.sh "cat /etc/profile.d/java.sh"

