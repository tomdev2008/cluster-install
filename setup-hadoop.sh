#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.sh

$scriptpath/software_untar.sh $hadoop_home $hadoop_folder $hadoop_jar

echo set hadoop folders: data, log, tmp
mkdir -p $hadoop_log_dir
mkdir -p $hadoop_log_dir/hadoop
mkdir -p $hadoop_log_dir/yarn
mkdir -p $hadoop_tmp_dir
mkdir -p $hadoop_data_dir
mkdir -p $hadoop_data_dir/name
mkdir -p $hadoop_data_dir/data

echo set /etc/profile.d/hadoop.sh
echo export HADOOP_HOME=$hadoop_home  > $hadoop_home/hadoop.sh
echo export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin >> $hadoop_home/hadoop.sh
echo export HADOOP_CONF_DIR=$hadoop_home/etc/hadoop >> $hadoop_home/hadoop.sh
echo export HADOOP_LOG_DIR=$hadoop_log_dir/hadoop  >> $hadoop_home/hadoop.sh

echo export HADOOP_YARN_HOME=$hadoop_home >> $hadoop_home/hadoop.sh
echo export YARN_HOME=$hadoop_home >> $hadoop_home/hadoop.sh
echo export YARN_CONF_DIR=$hadoop_home/etc/hadoop >> $hadoop_home/hadoop.sh
echo export YARN_LOG_DIR=$hadoop_log_dir/yarn  >> $hadoop_home/hadoop.sh

sudo mv $hadoop_home/hadoop.sh /etc/profile.d

echo set $hadoop_home/etc/hadoop/slaves/hadoop-env.sh
if ! grep -q -i "^export JAVA_HOME=$java_home$" $hadoop_home/etc/hadoop/hadoop-env.sh
then
  echo export JAVA_HOME=$java_home >> $hadoop_home/etc/hadoop/hadoop-env.sh
fi

echo set $hadoop_home/etc/hadoop/slaves $hadoop_master $hadoop_servers
$scriptpath/slaves.sh $hadoop_home/etc/hadoop/slaves $hadoop_master $hadoop_servers

echo set $hadoop_home/etc/hadoop/core-site.xml
echo \<?xml version=\"1.0\" encoding=\"UTF-8\"?\>                        >  $hadoop_home/etc/hadoop/core-site.xml
echo \<?xml-stylesheet type=\"text/xsl\" href=\"configuration.xsl\"?\>   >> $hadoop_home/etc/hadoop/core-site.xml
echo \<configuration\>                                               >> $hadoop_home/etc/hadoop/core-site.xml
echo   \<property\>                                                  >> $hadoop_home/etc/hadoop/core-site.xml
echo      \<name\>fs.default.name \</name\>                          >> $hadoop_home/etc/hadoop/core-site.xml
echo      \<value\>hdfs://$hadoop_master:$hadoop_hdfs_port\</value\>                   >> $hadoop_home/etc/hadoop/core-site.xml
echo   \</property\>                                                 >> $hadoop_home/etc/hadoop/core-site.xml
echo   \<property\>                                                  >> $hadoop_home/etc/hadoop/core-site.xml
echo     \<name\>hadoop.tmp.dir\</name\>                             >> $hadoop_home/etc/hadoop/core-site.xml
echo     \<value\>file://$hadoop_tmp_dir\</value\>                   >> $hadoop_home/etc/hadoop/core-site.xml
echo     \<description\>\</description\>                             >> $hadoop_home/etc/hadoop/core-site.xml
echo   \</property\>                                                 >> $hadoop_home/etc/hadoop/core-site.xml
echo \</configuration\>                                              >> $hadoop_home/etc/hadoop/core-site.xml

echo set $hadoop_home/etc/hadoop/hdfs-site.xml
echo \<?xml version=\"1.0\" encoding=\"UTF-8\"?\>                        >  $hadoop_home/etc/hadoop/hdfs-site.xml
echo \<?xml-stylesheet type=\"text/xsl\" href=\"configuration.xsl\"?\>   >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo \<configuration\>                                               >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo   \<property\>                                                  >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo     \<name\>dfs.namenode.secondary.http-address\</name\>                      >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo     \<value\>hdfs://$hadoop_master:9001\</value\>             >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo   \</property\>                                                 >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo   \<property\>                                                  >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo     \<name\>dfs.namenode.name.dir\</name\>                      >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo     \<value\>file://$hadoop_data_dir/name\</value\>             >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo   \</property\>                                                 >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo   \<property\>                                                  >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo     \<name\>dfs.datanode.data.dir\</name\>                      >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo     \<value\>file://$hadoop_data_dir/data\</value\>             >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo   \</property\>                                                 >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo   \<property\>                                                  >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo     \<name\>dfs.replication\</name\>                            >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo     \<value\>$dfs_replication\</value\>                         >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo   \</property\>                                                 >> $hadoop_home/etc/hadoop/hdfs-site.xml
echo \</configuration\>                                              >> $hadoop_home/etc/hadoop/hdfs-site.xml

echo set $hadoop_home/etc/hadoop/mapred-site.xml
echo \<?xml version=\"1.0\" encoding=\"UTF-8\"?\>                        >  $hadoop_home/etc/hadoop/mapred-site.xml
echo \<?xml-stylesheet type=\"text/xsl\" href=\"configuration.xsl\"?\>   >> $hadoop_home/etc/hadoop/mapred-site.xml
echo \<configuration\>                                               >> $hadoop_home/etc/hadoop/mapred-site.xml
echo   \<property\>                                                  >> $hadoop_home/etc/hadoop/mapred-site.xml
echo     \<name\>mapreduce.framework.name\</name\>                   >> $hadoop_home/etc/hadoop/mapred-site.xml
echo     \<value\>yarn\</value\>                                     >> $hadoop_home/etc/hadoop/mapred-site.xml
echo   \</property\>                                                 >> $hadoop_home/etc/hadoop/mapred-site.xml
echo \</configuration\>                                              >> $hadoop_home/etc/hadoop/mapred-site.xml

echo set $hadoop_home/etc/hadoop/yarn-site.xml
echo \<?xml version=\"1.0\" encoding=\"UTF-8\"?\>                        >  $hadoop_home/etc/hadoop/yarn-site.xml
echo \<?xml-stylesheet type=\"text/xsl\" href=\"configuration.xsl\"?\>   >> $hadoop_home/etc/hadoop/yarn-site.xml
echo \<configuration\>                                               >> $hadoop_home/etc/hadoop/yarn-site.xml
echo   \<property\>                                                  >> $hadoop_home/etc/hadoop/yarn-site.xml
echo     \<name\>yarn.nodemanager.aux-services\</name\>              >> $hadoop_home/etc/hadoop/yarn-site.xml
echo     \<value\>mapreduce_shuffle\</value\>                        >> $hadoop_home/etc/hadoop/yarn-site.xml
echo   \</property\>                                                 >> $hadoop_home/etc/hadoop/yarn-site.xml
echo   \<property\>                                                  >> $hadoop_home/etc/hadoop/yarn-site.xml
echo     \<name\>yarn.resourcemanager.address\</name\>              >> $hadoop_home/etc/hadoop/yarn-site.xml
echo     \<value\>$hadoop_master:8032\</value\>                        >> $hadoop_home/etc/hadoop/yarn-site.xml
echo   \</property\>                                                 >> $hadoop_home/etc/hadoop/yarn-site.xml
echo   \<property\>                                                  >> $hadoop_home/etc/hadoop/yarn-site.xml
echo     \<name\>yarn.resourcemanager.scheduler.address\</name\>              >> $hadoop_home/etc/hadoop/yarn-site.xml
echo     \<value\>$hadoop_master:8030\</value\>                        >> $hadoop_home/etc/hadoop/yarn-site.xml
echo   \</property\>                                                 >> $hadoop_home/etc/hadoop/yarn-site.xml
echo   \<property\>                                                  >> $hadoop_home/etc/hadoop/yarn-site.xml
echo     \<name\>yarn.resourcemanager.resource-tracker.address\</name\>              >> $hadoop_home/etc/hadoop/yarn-site.xml
echo     \<value\>$hadoop_master:8031\</value\>                        >> $hadoop_home/etc/hadoop/yarn-site.xml
echo   \</property\>                                                 >> $hadoop_home/etc/hadoop/yarn-site.xml
echo   \<property\>                                                  >> $hadoop_home/etc/hadoop/yarn-site.xml
echo     \<name\>yarn.resourcemanager.admin.address\</name\>              >> $hadoop_home/etc/hadoop/yarn-site.xml
echo     \<value\>$hadoop_master:8033\</value\>                        >> $hadoop_home/etc/hadoop/yarn-site.xml
echo   \</property\>                                                 >> $hadoop_home/etc/hadoop/yarn-site.xml
echo \</configuration\>                                              >> $hadoop_home/etc/hadoop/yarn-site.xml


$scriptpath/command-with-text.sh " ll $hadoop_log_dir"
$scriptpath/command-with-text.sh " ll $hadoop_data_dir"
$scriptpath/command-with-text.sh " ll $hadoop_tmp_dir"

$scriptpath/command-with-text.sh " ls -l $hadoop_home"
$scriptpath/command-with-text.sh " ls -l $aapath | grep $hadoop_folder"
$scriptpath/command-with-text.sh " cat /etc/profile.d/hadoop.sh"

$scriptpath/command-with-text.sh " cat $hadoop_home/etc/hadoop/hadoop-env.sh "
$scriptpath/command-with-text.sh " cat $hadoop_home/etc/hadoop/slaves "
$scriptpath/command-with-text.sh " cat $hadoop_home/etc/hadoop/core-site.xml "
$scriptpath/command-with-text.sh " cat $hadoop_home/etc/hadoop/hdfs-site.xml "
$scriptpath/command-with-text.sh " cat $hadoop_home/etc/hadoop/mapred-site.xml "
$scriptpath/command-with-text.sh " cat $hadoop_home/etc/hadoop/yarn-site.xml "

echo setup hadoop is finished on `hostname`

