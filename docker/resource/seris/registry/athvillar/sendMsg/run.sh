#!/bin/bash

param1=$1
shift 1
param2=$*
if [ "$SERIS_NODEID" = "$param1" ]; then
  echo "Hi. I'm $param1. I've received your msg: $param2"
  exit 1
fi
exit 0
