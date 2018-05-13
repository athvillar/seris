#!/bin/bash

nid=$1
nip=$2
nport=$3

if [ "$nport" != "" ]; then
  if [ "$SERIS_META_PATH" = "" ]; then
    export SERIS_LINKED_NODES=$SERIS_LINKED_NODES:$nid,$nip,$nport
    echo $SERIS_LINKED_NODES
  else
    echo $nid,$nip,$nport >> $SERIS_META_PATH/node_list
    echo "$nid,$nip,$nport"
  fi
fi
