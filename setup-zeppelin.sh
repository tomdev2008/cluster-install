#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.sh

#if [ ! -d $aapath/zeppelin-0.5.5-incubating  ]
#then
#  wget http://mirror.olnevhost.net/pub/apache/incubator/zeppelin/0.5.5-incubating/zeppelin-0.5.5-incubating.tgz
#  tar -zxf zeppelin-0.5.5-incubating.tgz -C $aapath
#  rm -rf zeppelin-0.5.5-incubating.tgz
#fi

#rm -rf $aapath/zeppelin-incubator
#ln -s $aapath/zeppelin-0.5.5-incubating $aapath/zeppelin-incubator
#cd $aapath/zeppelin-incubator

oldpath=`pwd`
cd $aapath
git clone https://github.com/apache/incubator-zeppelin.git
cd incubator-zeppelin

mvn clean package -DskipTests -Pspark-1.5 -Phadoop-2.6 
cp $aapath/zeppelin-incubator/conf/zeppelin-env.sh.template $aapath/zeppelin-incubator/conf/zeppelin-env.sh
export MASTER=spark://$spark_master:7077
export SPARK_HOME=$spark_home
export SPARK_SUBMIT_OPTIONS="--driver-memory 512M --executor-memory 1G"
export HADOOP_CONF_DIR==$hadoop_home/etc/hadoop
export ZEPPELIN_PORT=9090
#export ZEPPELIN_JAVA_OPTS=""

cp $aapath/zeppelin-incubator/conf/zeppelin-site.xml.template $aapath/zeppelin-incubator/conf/zeppelin-site.xml

cd $oldpath

