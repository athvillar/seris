#!/bin/sh
#set -x

SERIS_HOME=`dirname $0`/..

if [ $# -lt 2 ]; then
  echo "Usage: $0 [target ip] [target port] [registry] <parameters>"
  exit 1
fi

#meta=$1
#if [ -f $SERIS_HOME/$meta/env ]; then
#  source $SERIS_HOME/$meta/env
#fi
source $SERIS_HOME/src/common.sh

target_ip=$1
target_port=$2
registry=$3
shift 3
param=$@

if [ "$registry" = "" ]; then
  echo "No registry specified"
  exit 1
fi
if [ ! -d $SERIS_HOME/registry/$registry ]; then
  echo "Registry [$registry] not found"
  exit 1
fi
source $SERIS_HOME/registry/$registry/env.sh

task_id=`randn 7`
msg_id=`randn 8`
echo "$msg_id ODR invoker localhost 1177 $task_id $ttl $max_time $timeout $dispatch $registry $param" | nc $target_ip $target_port

