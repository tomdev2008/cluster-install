#!/bin/bash
script=$(readlink -f "$0")
scriptpath=$(dirname "$script")
source $scriptpath/proxy.conf

SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"
PROXY_OPTS="-Dhttp.proxyHost=$http_host  -Dhttp.proxyPort=$http_port -Dhttps.proxyHost=$https_host  -Dhttps.proxyPort=$https_port"
java $PROXY_OPTS $SBT_OPTS -jar $scriptpath/sbt-lib/sbt-launch.jar "$@"

