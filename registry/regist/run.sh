#!/bin/bash

nid=$1
nip=$2
nport=$3

if [ "$nport" = "" ]; then
  export SERIS_LINKED_NODE=$SERIS_LINKED_NODE:$nid,$nip,$nport
fi
