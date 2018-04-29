#!/bin/bash

nid=$1
nip=$2
nport=$3

if [ "$nport" != "" ]; then
  if [ "$SERIS_META_PATH" = "" ]; then
    export SERIS_LINKED_NODE=$SERIS_LINKED_NODE:$nid,$nip,$nport
  else
    echo $nid,$nip,$nport >> $SERIS_META_PATH/node_list
  fi
fi
