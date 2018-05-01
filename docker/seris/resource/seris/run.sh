#!/bin/sh

export SERIS_HOME=`dirname $0`
export SERIS_SRC_PATH=$SERIS_HOME/src
export SERIS_REGISTRY_PATH=$SERIS_HOME/registry

meta=$1
if [ "$meta" != "" -a -d $SERIS_HOME/$meta ]; then
  export SERIS_META_PATH=$SERIS_HOME/$meta
  export SERIS_WORK_PATH=$SERIS_HOME/$meta/work
  source $SERIS_META_PATH/env
else
  export SERIS_WORK_PATH=$SERIS_HOME/work
  export SERIS_NODEID=`hostname`
  SERIS_HOST=`ip addr | grep 172 | awk '{ print $2 }' | awk -F / '{ print $1 }'`
  export SERIS_HOST=$SERIS_HOST
  export SERIS_PORT=1179
fi
if [ ! -f $SERIS_WORK_PATH/task_list ]; then
  echo "TASK_ID,FROM_NODE_ID,PID" > $SERIS_WORK_PATH/task_list
fi
if [ ! -f $SERIS_WORK_PATH/msg_list ]; then
  echo "TYPE,MSG_ID,TASK_ID,FROM_NODE_ID,SIGNAL" > $SERIS_WORK_PATH/msg_list
fi

$SERIS_SRC_PATH/listener.sh

