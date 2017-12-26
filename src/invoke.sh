#!/bin/bash
#set -x

SERIS_HOME=`dirname $0`/..

meta=$1
if [ "$meta" = "" ]; then
  echo "No meta folder specified, take 'meta' as default."
  meta="meta"
fi
source $SERIS_HOME/$meta/env
source $SERIS_HOME/src/common.sh

ttk=$2
max_time=$3
timeout=$3
dispatch=$4
registry=$5
param=$6

if [ "$registry" = "" ]; then
  echo "No registry specified"
  exit 1
fi

task_id=`randn 7`
msg_id=`randn 8`
#echo "$msg_id ODR exnodex localhost 1199 $task_id $ttk $max_time $timeout $dispatch $registry $param" | nc localhost $SERIS_PORT
echo "$msg_id ODR exnodex 172.17.0.16 1179 $task_id $ttk $max_time $timeout $dispatch $registry $param" | nc localhost $SERIS_PORT
