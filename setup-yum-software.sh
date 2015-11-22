#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/config.sh

declare -a servers_cwp=\(\"${servers//,/\" \"}\"\)

for server in "${servers_cwp[@]}"
do
  echo server=$server user=$user
  ssh $user@$server sudo yum install -y $1
done

