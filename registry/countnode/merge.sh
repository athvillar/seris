#!/bin/bash
#set -x

taskId=$1
sum=0
for num in `grep "finished" $metapath/task-$taskId | awk -F , '{ print $3 }'`; do
  sum=`expr $sum + $num`
done
echo $sum
