#!/bin/bash
#set -x

export SERIS_HOME=`dirname $0`/..
export SERIS_SRC_PATH=$SERIS_HOME/src
export SERIS_REGISTRY_PATH=$SERIS_HOME/registry

meta=$1
if [ "$meta" = "" ]; then
  echo "No meta folder specified, take 'meta' as default."
  meta="meta"
fi
export SERIS_META_PATH=$SERIS_HOME/$meta
export SERIS_WORK_PATH=$SERIS_HOME/$meta/work
source $SERIS_META_PATH/env
pipefile=$SERIS_WORK_PATH/ff-$$

mkfifo $pipefile
exec 6<>$pipefile
rm -f $pipefile
nc -lk -p $SERIS_PORT >&6 &
while read line <&6; do
  $SERIS_SRC_PATH/controller.sh $line &
done

