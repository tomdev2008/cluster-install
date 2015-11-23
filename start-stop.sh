#Start/Stop Cluster:
source ~/cluster/cluster-install/config.sh

format namenode
hdfs namenode -format

Start Hadoop
start-dfs.sh
start-yarn.sh
jps
hdfs dfsadmin -report
or
http://c1t14285.itcs.hpicorp.net:50070/dfshealth.html
http://c1t14285.itcs.hpicorp.net:8088/cluster/nodes
http://aa01:50070/dfshealth.html
http://aa01:8088/cluster/nodes

Testing Hadoop
hadoop fs -mkdir /input
hadoop fs -put ~/cluster/cluster-install/*.sh /input
hadoop fs -ls /input

hadoop fs -mkdir /output
hadoop fs -rm -r /output/wordcount
yarn jar $hadoop_home/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar wordcount /input /output/wordcount
hadoop fs -cat /output/wordcount/*

Start Spark
$spark_home/sbin/start-all.sh
jps
http://aa01:8080
http://c1t14285.itcs.hpicorp.net:8080

Start Spark History Server
$spark_home/sbin/start-history-server.sh
http://aa01:18080/

Testing Spark
spark-submit --master yarn --class org.apache.spark.examples.JavaWordCount $spark_home/lib/spark-examples-1.5.2-hadoop2.6.0.jar /input/config.sh
spark-submit --master spark://$spark_master:7077 --class org.apache.spark.examples.JavaWordCount $spark_home/lib/spark-examples-1.5.2-hadoop2.6.0.jar /input/config.sh


Add Node to Spark Cluster
nohup spark-class org.apache.spark.deploy.worker.Worker spark://$master:7077 &

Dynamic Adding node:
hadoop-daemon.sh start datanode
yarn-daemons.sh  start nodemanager



Close Hadoop
stop-yarn.sh
stop-dfs.sh

Close Spark
$spark_home/sbin/stop-all.sh
jps

stop Spark APP
spark-class org.apache.spark.deploy.Client kill spark://$master:7077 app-20150302143620-0009

Flume
source ~/cluster-install/config.sh

http://www.aboutyun.com/thread-8917-1-1.html
#case 1: Avro
$flume_home/bin/flume-ng agent -c . -f /opt/mount1/seals/flume_test/avro.conf -n a1 -Dflume.root.logger=INFO,console
echo "hello world" > $flume_home/log.00
$flume_home/bin/flume-ng avro-client -c . -H c1t14289.itcs.hpicorp.net -p 4141 -F $flume_home/log.00
$flume_home/bin/flume-ng avro-client -c . -H c1t14289.itcs.hpicorp.net -p 4141 -F /

#case 2: Spool
$flume_home/bin/flume-ng agent -c . -f /opt/mount1/seals/flume_test/spool.conf -n a1 -Dflume.root.logger=INFO,console
echo "spool test1" > /opt/mount1/seals/flume_test/logs/spool_text.log

#case 3: Exec
$flume_home/bin/flume-ng agent -c . -f /opt/mount1/seals/flume_test/exec_tail.conf -n a1 -Dflume.root.logger=INFO,console
for i in {1..50};do date >> /opt/mount1/seals/flume_test/logs/log_exec_tail; sleep 1; done

#case 4:  Syslogtcp
$flume_home/bin/flume-ng agent -c . -f /opt/mount1/seals/flume_test/syslog_tcp.conf -n a1 -Dflume.root.logger=INFO,console
echo "hello idoall.org syslog" | nc localhost 5140

#case 5  JSONHandler
$flume_home/bin/flume-ng agent -c . -f /opt/mount1/seals/flume_test/post_json.conf -n a1 -Dflume.root.logger=INFO,console
curl -X POST -d '[{ "headers" :{"a" : "a1","b" : "b1"},"body" : "idoall.org_body"}]' http://localhost:8888

#case 6  hadoop sink
$flume_home/bin/flume-ng agent -c . -f /opt/mount1/seals/flume_test/hdfs_sink.conf -n a1 -Dflume.root.logger=INFO,console
echo "hello idoall.org from flume" | nc localhost 5140

$flume_home/bin/flume-ng agent -c . -f /opt/mount1/seals/flume_test/spool_hdfs_sink.conf -n a1 -Dflume.root.logger=INFO,console

rm -rf /opt/mount1/seals/flume_test/logs/*
echo "spool test25" > /opt/mount1/seals/flume_test/logs/printer.log45
echo "spool test26" > /opt/mount1/seals/flume_test/logs/printer.log46
echo "spool test27" > /opt/mount1/seals/flume_test/logs/printer.log47
echo "spool test28" > /opt/mount1/seals/flume_test/logs/printer.log48
echo "spool test29" > /opt/mount1/seals/flume_test/logs/printer.log49

vim /opt/mount1/seals/flume_test/spool_hdfs_sink.conf
cat /opt/mount1/seals/flume_test/spool_hdfs_sink.conf
hadoop fs -ls  /user/grid/flume/
hadoop fs -rm -r -f /user/grid/flume/*
hadoop fs -cat /user/grid/flume/*

rm -rf /opt/mount1/seals/flume_test/logs/* ;for file in `ls /opt/mount1/seals/flume_test/source `; do  cp /opt/mount1/seals/flume_test/source/$file /opt/mount1/seals/flume_test/logs/$(date +%Y%m%d.%H%M%S).$file; sleep 2; done





Clear DFS
if you need to reformat hadoop dfs, please run the script.
make sure you have stop the hadoop cluster.
///  /home/grid/code/cleardfs.sh aa0[2,3,4,5,6]
///  /usr/hadoop/bin/hdfs namenode -format








