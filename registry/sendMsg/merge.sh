#!/bin/bash
#set -x

taskId=$1
for line in `grep "finished" $metapath/task-$taskId | awk -F , '{ print $3 }'`; do
  if [ "$line" != "" ]; then
    line2=`grep ",finished,$line" $metapath/task-$taskId | awk -F , '{ print $3 }'`
    echo $line2
    exit
  fi
done
