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

if [ ! -d $aapath/incubator-zeppelin  ]
then 
  cd $aapath
  git config --global http.proxy http://web-proxy.atl.hp.com:8080
  git clone https://github.com/apache/incubator-zeppelin.git
fi
cd $aapath/incubator-zeppelin

mvn clean package -DskipTests -Pspark-1.5 -Phadoop-2.6 
cp conf/zeppelin-env.sh.template conf/zeppelin-env.sh
echo export MASTER=spark://$spark_master:7077                                 >> conf/zeppelin-env.sh
echo export SPARK_HOME=$spark_home                                            >> conf/zeppelin-env.sh
echo export SPARK_SUBMIT_OPTIONS="--driver-memory 512M --executor-memory 1G"  >> conf/zeppelin-env.sh
echo export HADOOP_CONF_DIR==$hadoop_home/etc/hadoop                          >> conf/zeppelin-env.sh
echo export ZEPPELIN_PORT=9090                                                >> conf/zeppelin-env.sh
echo #export ZEPPELIN_JAVA_OPTS=""                                            >> conf/zeppelin-env.sh

cp conf/zeppelin-site.xml.template conf/zeppelin-site.xml

cd $oldpath

