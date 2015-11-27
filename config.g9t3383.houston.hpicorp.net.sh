#!/bin/bash
# ----------------------------------------
# base information
# ----------------------------------------
servers=g9t3406.houston.hpicorp.net,g9t3412.houston.hpicorp.net,g9t3279.houston.hpicorp.net,g9t3429.houston.hpicorp.net,g9t3428.houston.hpicorp.net,g9t3280.houston.hpicorp.net,g9t3411.houston.hpicorp.net,g9t3410.houston.hpicorp.net,g9t3430.houston.hpicorp.net,g9t3421.houston.hpicorp.net
if [ ${servers_test:-""} != "" ]; then servers=$servers_test; fi
declare -a servers_cwp=\(\"${servers//,/\" \"}\"\)

master=c1t14285.itcs.hpicorp.net
user=grid
password=abc123@hp.com
aapath=/opt/mount1/grid
aapath1=/opt/mount2/grid

# ----------------------------------------
# cluster-environment and install
# ----------------------------------------
sourcepath=/home/$user/cluster/cluster-install
copypath=/home/$user
targetpath=$copypath/cluster-install
softwarepath=/home/$user/cluster/software

# ----------------------------------------
# shiny
# ----------------------------------------
shinypath=$aapath/shinyapp

# ----------------------------------------
# java
# ----------------------------------------
java_home=$aapath/java
java_folder=jdk1.7.0_72
java_jar=jdk-7u72-linux-x64.gz

# ----------------------------------------
# scala
# ----------------------------------------
scala_home=$aapath/scala
scala_folder=scala-2.10.4
scala_jar=scala-2.10.4.tgz

# ----------------------------------------
# hadoop
# ----------------------------------------
hadoop_servers=$servers
hadoop_master=
hadoop_home=$aapath/hadoop
hadoop_folder=hadoop-2.7.1
hadoop_jar=$hadoop_folder.tar.gz

hadoop_hdfs_port=9000
hadoop_data_dir=$aapath1/hadoop/hdfs
hadoop_tmp_dir=$aapath1/hadoop/tmp
hadoop_log_dir=$aapath1/hadoop/logs
dfs_replication=2

# ----------------------------------------
# spark
# ----------------------------------------
spark_servers=$servers
spark_master=
spark_home=$aapath/spark
spark_folder=spark-1.5.2-bin-hadoop2.6
spark_jar=$spark_folder.tgz

spark_eventLog_dir=/var/log/spark
spark_tmp_dir=$spark_tmp_dir
spark_log_dir=$aapath1/spark/logs

# ----------------------------------------
# flume
# ----------------------------------------
flume_servers=
flume_home=$aapath/flume
flume_folder=apache-flume-1.6.0-bin
flume_jar=$flume_folder.tar.gz


# ----------------------------------------

