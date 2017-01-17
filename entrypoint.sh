#!/bin/sh
echo "$1" >> /tmp/zookeeper/myid

./zkServer.sh start-foreground
