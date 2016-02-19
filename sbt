#!/bin/bash
SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"
PROXY_OPTS="-Dhttp.proxyHost=web-proxy.atl.hp.com  -Dhttp.proxyPort=8080 -Dhttps.proxyHost=web-proxy.atl.hp.com  -Dhttps.proxyPort=8080"
java $PROXY_OPTS $SBT_OPTS -jar `dirname $0`/sbt-lib/sbt-launch.jar "$@"

