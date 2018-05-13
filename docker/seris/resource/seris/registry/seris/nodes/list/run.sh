#!/bin/bash

if [ "$SERIS_META_PATH" != "" && -f $SERIS_META_PATH/node_list ]; then
  cat $SERIS_META_PATH/node_list
else
  echo $SERIS_LINKED_NODES
fi
