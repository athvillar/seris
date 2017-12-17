#!/bin/bash

param1=$1
param2=$2

#echo "p1:$param1, p2:$param2"

ping -c $param2 $param1 1>/dev/null 2>&1
echo $param2
exit 0
