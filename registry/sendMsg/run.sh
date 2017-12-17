#!/bin/bash

param1=$1
shift 1
param2=$*
if [ "$selfNodeId" = "$param1" ]; then
  echo "Hi. I'm $param1. I've received your msg: $param2"
  #echo "Hi, I'm $param1, I've received your msg: $param2">>~/Documents/comm/test/1.txt
  exit 1
fi
exit 0
