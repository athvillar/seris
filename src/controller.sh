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

export metapath=$basepath/$meta
source $metapath/env

function check() {
  # ttk check
  newTtk=`expr $ttk - 1`
  if [ $newTtk -lt 0 ]; then
    exit 2
  fi
  # duplicate task check
  if [ -f $metapath/tasklist ]; then
    taskExist=`grep $taskId $metapath/tasklist`
    if [ "$taskExist" != "" ]; then
      exit 2
    fi
  fi
  echo $taskId $fromNodeId >> $metapath/tasklist
}

function responseback() {
  # response back
  selfNodeId=`cat $metapath/selfnode | awk -F , '{ print $1 }'`
  echo "$selfNodeId STT $taskId" | nc $fromNodeHost $fromNodePort
}

function dispatch() {
  # dispatch
  selfNodeId=`cat $metapath/selfnode | awk -F , '{ print $1 }'`
  selfNodeHost=`cat $metapath/selfnode | awk -F , '{ print $2 }'`
  selfNodePort=`cat $metapath/selfnode | awk -F , '{ print $3 }'`
  for node in `cat $metapath/nodelist`; do
    arr=(${node//,/ })
    toNodeId=${arr[0]}
    toNodeHost=${arr[1]}
    toNodePort=${arr[2]}
    if [ "$toNodeId" != "$fromNodeId" ]; then
      newtimeout=`expr $timeout - 1`
      echo "$selfNodeId ODR $selfNodeHost $selfNodePort $taskId $newTtk $newtimeout $dispatch $registry $param" | nc $toNodeHost $toNodePort
      echo $toNodeId",sent" >> $metapath/task-$taskId
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
      rtn=`$registrypath/$registry/run.sh $param`
      echo "self,finished,"$rtn >> $metapath/task-$taskId
    else
      rtn=`$registrypath/$registry/run.sh $param`
      sts=$?
      echo "self,finished,"$rtn >> $metapath/task-$taskId
      if [ "$sts" = "$dispatch" ]; then
        dispatch
      fi
    fi
    rtn=`$srcpath/taskmonitor.sh $registry $taskId $timeout`
#echo "RTNRTNRTN $metapath:$rtn"
    seconds=`echo "sclae=3; $RANDOM*0.00001" | bc`
    sleep $seconds
    returnback $rtn
  ;;
  STT)
    echo $fromNodeId",started" >> $metapath/task-$taskId
  ;;
  FNS)
    echo $fromNodeId",finished,"$result >> $metapath/task-$taskId
#echo "FNS received:"$meta", from:$fromNodeId writed"
  ;;
esac

