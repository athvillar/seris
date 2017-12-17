#!/bin/bash
#set -x

basepath=`dirname $0`/..

meta=$1
if [ "$meta" = "" ]; then
  echo "No meta folder specified, take 'meta' as default."
  meta="meta"
fi
source $basepath/$meta/env

ttk=$2
timeout=$3
dispatch=$4
registry=$5
param=$6

if [ "$registry" = "" ]; then
  echo "No registry specified"
  exit 1
fi

selfNodeId=`cat $basepath/$meta/selfnode | awk -F , '{ print $1 }'`
port=`cat $basepath/$meta/selfnode | awk -F , '{ print $3 }'`
#echo "ax ODR localhost 1199 $RANDOM $ttk $timeout $dispatch $registry $param"
echo "ax ODR localhost 1199 $RANDOM $ttk $timeout $dispatch $registry $param" | nc localhost $port
