#!/bin/bash

param=$1
if [ "$SERIS_NODEID" = "$param" ]; then
  echo "$SERIS_NODEID:$SERIS_HOST:$SERIS_PORT"
  exit 1
fi
exit 0
