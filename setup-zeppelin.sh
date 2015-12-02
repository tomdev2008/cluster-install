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
mvn clean package -DskipTests -Pspark-1.5 -Phadoop-2.6 -Ppyspark


