#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.sh

if [ ! -d $aapath/zeppelin-0.5.5-incubating  ]
then
  wget http://mirror.olnevhost.net/pub/apache/incubator/zeppelin/0.5.5-incubating/zeppelin-0.5.5-incubating.tgz
  tar -zxf zeppelin-0.5.5-incubating.tgz -C $aapath
  rm -rf zeppelin-0.5.5-incubating.tgz
fi

rm -rf $aapath/zeppelin-incubator
ln -s $aapath/zeppelin-0.5.5-incubating $aapath/zeppelin-incubator
cd $aapath/zeppelin-incubator

#sudo yum install -y npm 
#sudo yum install -y libfontconfig 
mvn clean package -DskipTests -Pspark-1.5 -Phadoop-2.6 
cp $aapath/zeppelin-incubator/conf/zeppelin-env.sh.template $aapath/zeppelin-incubator/conf/zeppelin-env.sh
export MASTER=spark://$spark_master:7077
export SPARK_HOME=$spark_home
export HADOOP_HOME=$hadoop_home

cp $aapath/zeppelin-incubator/conf/zeppelin-site.xml.template $aapath/zeppelin-incubator/conf/zeppelin-site.xml