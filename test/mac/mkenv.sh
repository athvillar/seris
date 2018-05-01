#!/bin/bash
#set -x

SERIS_HOME=`dirname $0`"/../.."
SERIS_SRC_PATH=$SERIS_HOME/src
SERIS_TEST_PATH=$SERIS_HOME/test/mac

i=0
for line in `cat $SERIS_TEST_PATH/node_list`; do
  SERIS_META_PATH=$SERIS_HOME/meta-$i
  SERIS_WORK_PATH=$SERIS_META_PATH/work
  rm -rf $SERIS_META_PATH
  mkdir -p $SERIS_WORK_PATH

  selfNodeId=`echo $line | awk -F , '{ print $1 }'`
  selfNodeHost=`echo $line | awk -F , '{ print $2 }'`
  selfNodePort=`echo $line | awk -F , '{ print $3 }'`
  for line2 in `cat $SERIS_TEST_PATH/nodemap | grep "$selfNodeId,"`; do
    connNodeId=`echo $line2 | awk -F , '{ print $2 }'`
    connNodePort=`cat $SERIS_TEST_PATH/node_list | grep "$connNodeId," | awk -F , '{ print $3 }'`
    echo $connNodeId",localhost,"$connNodePort >> $SERIS_META_PATH/node_list
    #export SERIS_LINKED_NODE=$SERIS_LINKED_NODE:$connNodeId",localhost,"$connNodePort
  done

  echo "export SERIS_NODEID="$selfNodeId > $SERIS_META_PATH/env
  echo "export SERIS_HOST="$selfNodeHost >> $SERIS_META_PATH/env
  echo "export SERIS_PORT="$selfNodePort >> $SERIS_META_PATH/env

  $SERIS_HOME/run.sh meta-$i &
  i=`expr $i + 1`
done
