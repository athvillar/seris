#!/bin/bash

thispath=`dirname $0`
for cid in `cat $thispath/container_list | awk -F , '{ print $1 }'`; do
  docker stop $cid
  docker rm $cid
done 
