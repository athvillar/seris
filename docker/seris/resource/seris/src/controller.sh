#!/bin/bash
#set -x

source $SERIS_SRC_PATH/common.sh
function get_param() {

  msg_id=$1
  signal=$2
  from_node_id=$3

  if [ "$signal" = "ODR" ]; then
    from_node_host=$4
    from_node_port=$5
    task_id=$6
    ttl=$7
    max_time=$8
    timeout=$9
    dispatch_condition=${10}
    registry=${11}
    shift 11
    param=$@
  elif [ "$signal" = "CNC" ]; then
    task_id=$4
  elif [ "$signal" = "HBT" ]; then
    task_id=$4
    dispatched_nodes=$5
    elapsed_time=$6
    estimated_time=$7
  elif [ "$signal" = "RST" ]; then
    task_id=$4
    total_index=$5
    index=$6
    shift 6
    result=$@
  elif [ "$signal" = "GTT" ]; then
    task_id=$4
    corresponding_msg_id=$5
  else
    echo "$0: Wrong signal specified("$signal")"
    exit 1
  fi

  echo "RCV,${msg_id},${task_id},${from_node_id},${signal}" >> $SERIS_WORK_PATH/msg_list
}

function check_task() {
  # registry check
  if [ "$registry" = "" ]; then
    echo "No registry specified"
    exit 1
  fi
  # ttl check
  newTtl=`expr $ttl - 1`
  if [ $newTtl -lt 0 ]; then
    exit 2
  fi
  # duplicate task check
  echo $task_id","$from_node_id","$$ >> $SERIS_WORK_PATH/task_list
  first_PID=`grep "^$task_id" $SERIS_WORK_PATH/task_list | head -1 | awk -F , '{ print $3 }'`
  if [ "$$" != "$first_PID" ]; then
    exit 2
  fi
}

function response_back() {
  # response back
  new_msg_id=`randn 8`
  echo "$new_msg_id GTT $SERIS_NODEID $task_id $msg_id" | nc $from_node_host $from_node_port
  echo "SND,$new_msg_id,$task_id,$from_node_id,GTT" >> $SERIS_WORK_PATH/msg_list
}

function dispatch() {
  # dispatch
  #for node in `cat $SERIS_META_PATH/node_list`; do
  for node in `get_linked_node_list`; do
    arr=(${node//,/ })
    to_node_id=${arr[0]}
    to_node_host=${arr[1]}
    to_node_port=${arr[2]}
    if [ "$to_node_id" != "$from_node_id" ]; then
      newtimeout=`expr $timeout - 1`
      new_msg_id=`randn 8`
      echo "$new_msg_id ODR $SERIS_NODEID $SERIS_HOST $SERIS_PORT $task_id $newTtl $max_time $newtimeout $dispatch_condition $registry $param" | nc $to_node_host $to_node_port
      echo "SND,$new_msg_id,$task_id,$to_node_id,ODR" >> $SERIS_WORK_PATH/msg_list
      echo $to_node_id",sent" >> $SERIS_WORK_PATH/task-$task_id
    fi
  done
}

function return_back() {
  new_msg_id=`randn 8`
  echo "$new_msg_id RST $SERIS_NODEID $task_id 1 1 $@" | nc $from_node_host $from_node_port
  echo "SND,$new_msg_id,$task_id,$from_node_id,RST" >> $SERIS_WORK_PATH/msg_list
}

function execute() {
  case "$signal" in
  ODR)
    check_task
    response_back
    if [ "$dispatch_condition" = "ALL" ]; then
      dispatch
      rtn=`$SERIS_REGISTRY_PATH/$registry/run.sh $param`
      echo "self,finished,"$rtn >> $SERIS_WORK_PATH/task-$task_id
    else
      rtn=`$SERIS_REGISTRY_PATH/$registry/run.sh $param`
      sts=$?
      echo "self,finished,"$rtn >> $SERIS_WORK_PATH/task-$task_id
      if [ "$sts" = "$dispatch_condition" ]; then
        dispatch
      fi
    fi
    rtn=`$SERIS_SRC_PATH/taskmonitor.sh $registry $task_id $timeout`
    return_back $rtn
  ;;
  CNC)
    for task_pid in `grep "^$task_id," $SERIS_WORK_PATH/task_list | awk -F , '{ print $3 }'`; do
      kill -9 $task_pid
    done
  ;;
  HBT)
    # do nothing
    signal="HBT"
  ;;
  RST)
    echo $from_node_id",finished,"$result >> $SERIS_WORK_PATH/task-$task_id
  ;;
  GTT)
    corresponding_signal=`grep "^SND,$corresponding_msg_id,$task_id,$from_node_id," $SERIS_WORK_PATH/msg_list | awk -F , '{ print $5 }'`
    case "$corresponding_signal" in
    ODR)
      echo $from_node_id",started" >> $SERIS_WORK_PATH/task-$task_id
    ;;
    RST)
      # do nothing
      corresponding_signal="RST"
    ;;
    esac
  ;;
  esac
}

get_param $*
execute

