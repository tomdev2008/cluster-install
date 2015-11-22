export x=1
y=2
echo $x
echo $y
echo servers=$servers
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.sh
echo servers=$servers

master=`hostname`
server=aa01
  if [ $server != $master ]
  then  echo $server
  fi
