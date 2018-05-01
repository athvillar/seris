#!/bin/bash

thispath=`dirname $0`
container_list=$1
if [ "$container_list" = "" ]; then
  echo "no container to kill"
  exit 99
fi
for cid in `cat $container_list | awk -F , '{ print $1 }'`; do
  docker stop $cid
  docker rm $cid
done 
rm $container_list
