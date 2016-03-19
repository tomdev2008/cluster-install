00 start-stop.sh
05 before-config.sh
06 cluster-create-user.sh
    06.1 create-user.sh
10 config.sh
    10.1 config.sh.aa01.sh
    10.2 config.c1t14285.itcs.hpicorp.net.sh
    10.3 print-config.sh
    10.4 command-with-text.sh
    10.5 for-command.sh
15 net-proxy.sh
20 cluster-without-password.sh    
    20.1 without-password.sh
30 setup-environment.sh
    30.1 setup-pdsh.sh
32 setup-yum-software.sql  optional
33 software_untar.sh
40 setup-java.sh
41 setup-scala.sh
42 setup-python.sh
48 slaves.sh
50 setup-hadoop.sh
55 setup-flume.sh
60 setup-spark.sh
65 setup-shiny.sh
70 setup-zookeeper.sh
75 setup-kafka.sh
100 set-cluster-install-path.sh

source ~/cluster/cluster-install/config.`hostname`
source ~/cluster-install/config.`hostname`
  
export servers_test=aa02

#00 start-stop.sh
start-stop.sh

#05 before config.sh
vim ~/cluster/cluster-install/before-config.sh
~/cluster/cluster-install/cluster-create-user.sh xu6 CDEszaq821202

#10 change config.sh
vim ~/cluster/cluster-install/config.sh
~/cluster/cluster-install/print-config.sh

#15 set net proxy
sudo ~/cluster/cluster-install/net-proxy.sh

#20 set cluster without password
~/cluster/cluster-install/cluster-without-password.sh

#30 set environment
~/cluster/cluster-install/setup-environment.sh

#32  install some yum software  (optional)   
#if installing pdsh fails, try to install gcc first and then run setup-environment again
~/cluster/cluster-install/setup-yum-software.sh  gcc

#33 同步时间
pdsh -R ssh -w $user@$servers sudo cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
pdsh -R ssh -w $user@$servers sudo date $(wget -O - "http://www.timeapi.org/utc/in+four+hours" 2>/dev/null | sed s/[-T:+]/\ /g | awk '{print $2,$3,$4,$5,".",$6}' | tr -d " ")
pdsh -R ssh -w $user@$servers sudo date


#40 setup some basic development framework
pdsh -R ssh -w $user@$servers $targetpath/setup-java.sh
pdsh -R ssh -w $user@$servers $targetpath/setup-scala.sh
pdsh -R ssh -w $user@$servers $targetpath/setup-python.sh

#45 clear software
pdsh -R ssh -w $user@$servers rm -rf $aapath/$hadoop_folder
pdsh -R ssh -w $user@$servers rm -rf $hadoop_home
pdsh -R ssh -w $user@$servers rm -rf $aapath/$spark_folder
pdsh -R ssh -w $user@$servers rm -rf $spark_home


#50 setup hadoop
pdsh -R ssh -w $user@$servers $targetpath/setup-hadoop.sh
start-dfs.sh
start-yarn.sh
stop-dfs.sh
stop-yarn.sh

#55 setup flume
pdsh -R ssh -w $user@$flume_servers $targetpath/setup-flume.sh
pdsh -R ssh -w $user@$flume_servers $flume_home/bin/flume-ng version

#60 setup spark
pdsh -R ssh -w $user@$servers $targetpath/setup-spark.sh
$spark_home/sbin/start-all.sh
$spark_home/sbin/stop-all.sh

$spark_home/sbin/start-history-server.sh
$spark_home/sbin/stop-history-server.sh

#65 setup zeppelin
~/cluster/cluster-install/setup-zeppelin.sh 

#shiny server
nginxserver=
shinyserver=

LF
source ~/cluster/cluster-install/config.`hostname`
pdsh -R ssh -w $user@$servers sudo mkdir /opt/mount1/seals
pdsh -R ssh -w $user@$servers sudo chown -R grid:grid /opt/mount1/seals

#70 setup-zookeeper.sh
pdsh -R ssh -w $user@$zookeeper_servers $targetpath/setup-zookeeper.sh

pdsh -R ssh -w $user@$zookeeper_servers $zookeeper_home/bin/zkServer.sh start
pdsh -R ssh -w $user@$zookeeper_servers $zookeeper_home/bin/zkServer.sh status
pdsh -R ssh -w $user@$zookeeper_servers $zookeeper_home/bin/zkServer.sh stop


#75 setup kafka http://www.cnblogs.com/oftenlin/p/4047504.html
pdsh -R ssh -w $user@$kafka_servers $targetpath/setup-kafka.sh

pdsh -R ssh -w $user@$kafka_servers $kafka_home/bin/kafka-server-start.sh $kafka_home/config/server.properties &
pdsh -R ssh -w $user@$kafka_servers $kafka_home/bin/kafka-server-stop.sh $kafka_home/config/server.properties

#create topic
$kafka_home/bin/kafka-topics.sh --zookeeper $zookeeper_connect --topic test --replication-factor 2 --partitions 3 --create
$kafka_home/bin/kafka-topics.sh --describe --zookeeper $zookeeper_connect --topic test 
#list topic
$kafka_home/bin/kafka-topics.sh --list --zookeeper $zookeeper_connect
#generate message
$kafka_home/bin/kafka-console-producer.sh --broker-list $kafka_connect --topic test
#get message 
$kafka_home/bin/kafka-console-consumer.sh --zookeeper $zookeeper_connect --topic test --from-beginning

#100   set-cluster-install-path.sh
#set cluster-install path in  Path(environment variable)
~/cluster/cluster-install/set-cluster-install-path.sh