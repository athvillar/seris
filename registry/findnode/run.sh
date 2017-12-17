#!/bin/bash

param=$1
if [ "$selfNodeId" = "$param" ]; then
  echo "$selfNodeId $selfNodeHost $selfNodePort"
  exit 1
fi
exit 0
