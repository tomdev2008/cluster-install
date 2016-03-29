#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.`hostname`

$scriptpath/software-untar.sh $spark_home $spark_folder $spark_jar

echo $scriptpath/slaves.sh $spark_home/conf/slaves $spark_master $spark_servers
$scriptpath/slaves.sh $spark_home/conf/slaves $spark_master $spark_servers

echo mkdir $spark_log_dir
mkdir -p $spark_log_dir

echo $hadoop_home/bin/hadoop fs -mkdir -p $spark_eventLog_dir
$hadoop_home/bin/hadoop fs -mkdir -p $spark_eventLog_dir

echo set /etc/profile.d/spark.sh
echo export SPARK_HOME=$spark_home  > $spark_home/spark.sh
echo export PATH=\$PATH:\$SPARK_HOME/sbin:\$SPARK_HOME/bin >> $spark_home/spark.sh
sudo mv $spark_home/spark.sh /etc/profile.d

echo set $spark_home/conf/spark-env.sh
cp $spark_home/conf/spark-env.sh.template $spark_home/conf/spark-env.sh
echo export JAVA_HOME=$java_home                                              >> $spark_home/conf/spark-env.sh
echo export SCALA_HOME=$scala_home                                          >> $spark_home/conf/spark-env.sh
echo export SPARK_MASTER_IP=$spark_master                                         >> $spark_home/conf/spark-env.sh
#echo export HADOOP_HOME=$hadoop_home                                    >> $spark_home/conf/spark-env.sh
#echo export HADOOP_CONF_DIR=$hadoop_home/etc/hadoop             >> $spark_home/conf/spark-env.sh
#echo export SPARK_DRIVER_MEMORY=1G                                     >> $spark_home/conf/spark-env.sh
echo export SPARK_HISTORY_OPTS=\"-Dspark.history.ui.port=18080 -Dspark.history.retainedApplications=3 -Dspark.history.fs.logDirectory=hdfs://$spark_master:$hadoop_hdfs_port$spark_eventLog_dir\" >> $spark_home/conf/spark-env.sh

echo set $spark_home/conf/spark-defaults.conf
cp $spark_home/conf/spark-defaults.conf.template $spark_home/conf/spark-defaults.conf
echo spark.eventLog.enabled true                                                                       >> $spark_home/conf/spark-defaults.conf
echo spark.eventLog.dir hdfs://$spark_master:$hadoop_hdfs_port$spark_eventLog_dir >> $spark_home/conf/spark-defaults.conf
echo spark.eventLog.compress true                                                                     >> $spark_home/conf/spark-defaults.conf

$scriptpath/command-with-text.sh " ls $spark_log_dir"
$scriptpath/command-with-text.sh " ls -l $spark_home"
$scriptpath/command-with-text.sh " ls -l $aapath | grep $spark_folder"
$scriptpath/command-with-text.sh " cat /etc/profile.d/spark.sh"

$scriptpath/command-with-text.sh " cat $spark_home/conf/spark-env.sh"
$scriptpath/command-with-text.sh " cat $spark_home/conf/spark-defaults.conf "
$scriptpath/command-with-text.sh " cat $spark_home/conf/slaves "

echo setup spark is finished on `hostname`

