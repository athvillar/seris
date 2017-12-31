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
conn_host=`head -2 $SERIS_HOME/$meta/node_list | tail -1 | awk -F , '{ print $2 }'`
conn_port=`head -2 $SERIS_HOME/$meta/node_list | tail -1 | awk -F , '{ print $3 }'`
echo "$msg_id ODR $SERIS_NODEID $SERIS_HOST $SERIS_PORT $task_id $ttk $max_time $timeout $dispatch $registry $param" | nc $conn_host $conn_port
