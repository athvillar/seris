#!/bin/bash
#set -x

meta=$1
fromNodeId=$2
signal=$3

if [ "$signal" = "ODR" ]; then
  fromNodeHost=$4
  fromNodePort=$5
  taskId=$6
  ttk=$7
  timeout=$8
  dispatch=$9
  registry=${10}
  shift 10
  param=$@
elif [ "$signal" = "STT" ]; then
  taskId=$4
elif [ "$signal" = "FNS" ]; then
#echo "FNS received:"$meta", from:$fromNodeId, content=[$@]"
  taskId=$4
  shift 4
  result=$@
else
  echo "$0: Wrong signal specified("$signal")"
  exit 1
fi

#export SERIS_META_PATH=$SERIS_HOME/$meta
#source $SERIS_META_PATH/env

function check() {
  # ttk check
  newTtk=`expr $ttk - 1`
  if [ $newTtk -lt 0 ]; then
    exit 2
  fi
  # duplicate task check
  echo $taskId $fromNodeId >> $SERIS_META_PATH/tasklist
  firstFromNodeId=`grep $taskId $SERIS_META_PATH/tasklist | head -1 | awk '{ print $2 }'`
  if [ "$fromNodeId" != "$firstFromNodeId" ]; then
    exit 2
  fi
  #if [ -f $SERIS_META_PATH/task-$taskId ]; then
  #  exit 2
  #fi
  #touch $SERIS_META_PATH/task-$taskId
}

function responseback() {
  # response back
  selfNodeId=$SERIS_NODEID
  echo "$selfNodeId STT $taskId" | nc $fromNodeHost $fromNodePort
}

function dispatch() {
  # dispatch
  selfNodeId=$SERIS_NODEID
  selfNodeHost=$SERIS_HOST
  selfNodePort=$SERIS_PORT
  for node in `cat $SERIS_META_PATH/nodelist`; do
    arr=(${node//,/ })
    toNodeId=${arr[0]}
    toNodeHost=${arr[1]}
    toNodePort=${arr[2]}
    if [ "$toNodeId" != "$fromNodeId" ]; then
      newtimeout=`expr $timeout - 1`
      echo "$selfNodeId ODR $selfNodeHost $selfNodePort $taskId $newTtk $newtimeout $dispatch $registry $param" | nc $toNodeHost $toNodePort
      echo $toNodeId",sent" >> $SERIS_META_PATH/task-$taskId
    fi
  done
}

function returnback() {
  #echo "$selfNodeId FNS $taskId $@"
  echo "$selfNodeId FNS $taskId $@" | nc $fromNodeHost $fromNodePort
}

case "$signal" in
  ODR)
    if [ "$registry" = "" ]; then
      echo "No registry specified"
      exit 1
    fi
    check
    responseback
    if [ "$dispatch" = "ALL" ]; then
      dispatch
      rtn=`$SERIS_REGISTRY_PATH/$registry/run.sh $param`
      echo "self,finished,"$rtn >> $SERIS_META_PATH/task-$taskId
    else
      rtn=`$SERIS_REGISTRY_PATH/$registry/run.sh $param`
      sts=$?
      echo "self,finished,"$rtn >> $SERIS_META_PATH/task-$taskId
      if [ "$sts" = "$dispatch" ]; then
        dispatch
      fi
    fi
    rtn=`$SERIS_SRC_PATH/taskmonitor.sh $registry $taskId $timeout`
#echo "RTNRTNRTN $SERIS_META_PATH:$rtn"
    #seconds=`echo "sclae=3; $RANDOM*0.00001" | bc`
    #sleep $seconds
    returnback $rtn
  ;;
  STT)
    echo $fromNodeId",started" >> $SERIS_META_PATH/task-$taskId
  ;;
  FNS)
    echo $fromNodeId",finished,"$result >> $SERIS_META_PATH/task-$taskId
#echo "FNS received:"$meta", from:$fromNodeId writed"
  ;;
esac

