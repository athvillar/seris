#!/bin/bash

basepath=`dirname $0`
cmdname=`basename $0`

if [ $# != 1 ]; then
  echo "Usage: $cmdname [node number]"
  exit 99
fi
nodenumber=$1

counter=0
for ((i=0;i<$nodenumber;i++)); do
  counter=`expr $counter + $(cat $basepath/counterfile_$i)`
done
echo "$counter passwords tested"
