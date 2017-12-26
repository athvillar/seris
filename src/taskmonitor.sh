#!/bin/bash
#set -x

registry=$1
task_id=$2
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
  for node_id in `cat $SERIS_WORK_PATH/task-$task_id | grep "started" | awk -F , '{ print $1 }'`; do
    sth=`grep "^${node_id},finished" $SERIS_WORK_PATH/task-$task_id`   
    if [ "$sth" = "" ]; then
      isFinish="no"
      break
    fi
  done
  if [ "$isFinish" = "yes" ]; then
    break
  fi
done
#rtn=`$SERIS_REGISTRY_PATH/$registry/merge.sh $task_id`
source $SERIS_REGISTRY_PATH/$registry/reduce.sh
_pre_process
for _line in `grep ",finished," $SERIS_WORK_PATH/task-$task_id | awk -F , '{ print $3 }'`; do
  _process
done
rtn=`_post_process`

echo $rtn

