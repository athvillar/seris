#!/bin/bash
#set -x

registry=$1
taskId=$2
timeout=$3

starttime=`date +%s`
sleep $monitorwaittime
while true; do
  now=`date +%s`
  during=`expr $now - $starttime`
  if [ $during -gt $timeout ]; then
    break
  fi
  isFinish="yes"
  for nodeId in `cat $SERIS_META_PATH/task-$taskId | grep "started" | awk -F , '{ print $1 }'`; do
    sth=`grep "${nodeId},finished" $SERIS_META_PATH/task-$taskId`   
    if [ "$sth" = "" ]; then
      isFinish="no"
      break
    fi
  done
  if [ "$isFinish" = "yes" ]; then
    break
  fi
#  sleep 2
done
rtn=`$SERIS_REGISTRY_PATH/$registry/merge.sh $taskId`
echo $rtn

