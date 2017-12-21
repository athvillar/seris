#!/bin/bash
#set -x

export SERIS_HOME=`dirname $0`/..
export SERIS_SRC_PATH=$SERIS_HOME/src
export SERIS_REGISTRY_PATH=$SERIS_HOME/registry
export SERIS_WORK_PATH=$SERIS_HOME/work

pipefile=$SERIS_WORK_PATH/ff-$$

meta=$1
if [ "$meta" = "" ]; then
  echo "No meta folder specified, take 'meta' as default."
  meta="meta"
fi
export SERIS_META_PATH=$SERIS_HOME/$meta
source $SERIS_META_PATH/env

mkfifo $pipefile
exec 6<>$pipefile
rm -f $pipefile
nc -lk $SERIS_PORT >&6 &
while read rtn <&6; do
  $SERIS_SRC_PATH/controller.sh $meta $rtn &
done

