#!/bin/bash
#set -x

SERIS_HOME=`dirname $0`/..

if [ $# -lt 2 ]; then
  echo "Usage: $0 [meta path] [registry] <parameters>"
  exit 1
fi

meta=$1
source $SERIS_HOME/$meta/env
source $SERIS_HOME/src/common.sh

registry=$2
shift 2
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
echo "$msg_id ODR invoker localhost 1177 $task_id $ttk $max_time $timeout $dispatch $registry $param" | nc $SERIS_HOST $SERIS_PORT

