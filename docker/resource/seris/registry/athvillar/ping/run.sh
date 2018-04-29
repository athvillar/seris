#!/bin/bash

param1=$1
param2=$2

ping -c $param2 $param1 1>/dev/null 2>&1
echo $param2
exit 0
