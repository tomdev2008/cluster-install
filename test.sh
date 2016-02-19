export x=1
y=2
echo $x
echo $y
echo servers=$servers
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.`hostname`
echo servers=$servers

master=`hostname`
server=aa01
  if [ $server != $master ]
  then  echo $server
  fi

v1=abc
var1=${1:-$v1}
echo v1=$v1
echo 1=$1
echo var1=$var1
