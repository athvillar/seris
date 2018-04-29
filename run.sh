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
  export SERIS_HOST=localhost
  export SERIS_PORT=1179
fi

$SERIS_SRC_PATH/listener.sh
