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
max_time=$3
timeout=$3
dispatch=$4
registry=$5
param=$6

if [ "$registry" = "" ]; then
  echo "No registry specified"
  exit 1
fi

echo "00000001 ODR exnodex localhost 1199 $RANDOM $ttk $max_time $timeout $dispatch $registry $param" | nc localhost $SERIS_PORT
