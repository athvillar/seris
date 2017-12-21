#!/bin/bash
#set -x

SERIS_HOME=`dirname $0`/..

meta=$1
if [ "$meta" = "" ]; then
  echo "No meta folder specified, take 'meta' as default."
  meta="meta"
fi
source $SERIS_HOME/$meta/env

ttk=$2
timeout=$3
dispatch=$4
registry=$5
param=$6

if [ "$registry" = "" ]; then
  echo "No registry specified"
  exit 1
fi

#selfNodeId=`cat $SERIS_HOME/$meta/selfnode | awk -F , '{ print $1 }'`
selfNodeId=$SERIS_NODEID
#port=`cat $SERIS_HOME/$meta/selfnode | awk -F , '{ print $3 }'`
port=$SERIS_PORT
#echo "ax ODR localhost 1199 $RANDOM $ttk $timeout $dispatch $registry $param"
echo "ax ODR localhost 1199 $RANDOM $ttk $timeout $dispatch $registry $param" | nc localhost $port
