#!/bin/bash
#set -x

SERIS_HOME=`dirname $0`"/.."
SERIS_SRC_PATH=$SERIS_HOME/src
SERIS_WORK_PATH=$SERIS_HOME/work

i=0
for line in `cat $SERIS_HOME/test/nodelist`; do
  rm -rf $SERIS_HOME/meta$i
  mkdir $SERIS_HOME/meta$i
  echo $line > $SERIS_HOME/meta$i/selfnode
  selfNodeId=`echo $line | awk -F , '{ print $1 }'`
  selfNodeHost=`echo $line | awk -F , '{ print $2 }'`
  selfNodePort=`echo $line | awk -F , '{ print $3 }'`
  for line2 in `cat $SERIS_HOME/test/nodemap | grep "$selfNodeId,"`; do
    connNodeId=`echo $line2 | awk -F , '{ print $2 }'`
    connNodePort=`cat $SERIS_HOME/test/nodelist | grep "$connNodeId," | awk -F , '{ print $3 }'`
    echo $connNodeId",localhost,"$connNodePort >> $SERIS_HOME/meta$i/nodelist
  done
  echo "export SERIS_NODEID="$selfNodeId > $SERIS_HOME/meta$i/env
  echo "export SERIS_HOST="$selfNodeHost >> $SERIS_HOME/meta$i/env
  echo "export SERIS_PORT="$selfNodePort >> $SERIS_HOME/meta$i/env
  echo "export monitorwaittime=2" >> $SERIS_HOME/meta$i/env
  $SERIS_SRC_PATH/listener.sh meta$i &
  i=`expr $i + 1`
done
