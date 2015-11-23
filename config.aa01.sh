#!/bin/bash

echo ----------------------------------------
echo base information
echo ----------------------------------------
servers=aa01,aa02,aa03
if [ ${servers_test:-""} != "" ]; then servers=$servers_test; fi
declare -a servers_cwp=\(\"${servers//,/\" \"}\"\)

master=aa01
user=grid
password=grid 
aapath=/opt/mount1/aa
aapath1=/opt/mount2/aa

echo servers=$servers
echo master=$master
echo user=$user
echo password=$password
echo aapath=$aapath

echo 
echo ----------------------------------------
echo cluster-environment and install
echo ----------------------------------------
sourcepath=/home/$user/cluster/cluster-install
copypath=/home/$user
targetpath=$copypath/cluster-install
softwarepath=/home/$user/cluster/software

echo sourcepath=$sourcepath
echo copypath=$copypath
echo targetpath=$targetpath
echo softwarepath=$softwarepath

echo 
echo ----------------------------------------
echo shiny
echo ----------------------------------------
shinypath=$aapath/shinyapp
echo shinypath=$shinypath

echo 
echo ----------------------------------------
echo java
echo ----------------------------------------
java_home=$aapath/java
java_folder=jdk1.7.0_72
java_jar=jdk-7u72-linux-x64.gz

echo java_home=$java_home
echo java_folder=$java_folder
echo java_jar=$java_jar

echo 
echo ----------------------------------------
echo scala
echo ----------------------------------------
scala_home=$aapath/scala
scala_folder=scala-2.10.4
scala_jar=scala-2.10.4.tgz

echo scala_home=$scala_home
echo scala_folder=$scala_folder
echo scala_jar=$scala_jar

echo 
echo ----------------------------------------
echo hadoop
echo ----------------------------------------
hadoop_servers=$servers
hadoop_master=$master
hadoop_home=$aapath/hadoop
hadoop_folder=hadoop-2.7.1
hadoop_jar=$hadoop_folder.tar.gz


hadoop_hdfs_port=9000
hadoop_data_dir=/home/$user/hadoop/hdfs
hadoop_tmp_dir=/home/$user/hadoop/tmp
hadoop_log_dir=/home/$user/hadoop/logs
dfs_replication=2

echo hadoop_servers=$hadoop_servers
echo hadoop_master=$hadoop_master
echo hadoop_home=$hadoop_home
echo hadoop_folder=$hadoop_folder
echo hadoop_jar=$hadoop_jar

echo hadoop_hdfs_port=$hadoop_hdfs_port
echo hadoop_data_dir=$hadoop_data_dir
echo hadoop_tmp_dir =$hadoop_tmp_dir
echo hadoop_log_dir=$hadoop_log_dir
echo dfs_replication=$dfs_replication

echo 
echo ----------------------------------------
echo spark
echo ----------------------------------------
spark_servers=$servers
spark_master=$master
spark_home=$aapath/spark
spark_folder=spark-1.5.2-bin-hadoop2.6
spark_jar=$spark_folder.tgz

spark_eventLog_dir=/var/log/spark
spark_tmp_dir=$spark_tmp_dir
spark_log_dir=/home/$user/spark/logs

echo spark_servers=$spark_servers
echo spark_master=$spark_master
echo spark_home=$spark_home
echo spark_folder=$spark_folder
echo spark_jar=$spark_jar

echo spark_eventLog_dir=$spark_eventLog_dir
echo spark_tmp_dir=$spark_tmp_dir
echo spark_log_dir=$spark_log_dir

echo
echo ----------------------------------------

