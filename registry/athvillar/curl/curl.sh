#!/bin/bash

action=$1
param=$2

case "$action" in
  dispatch)
    while true; do
      curl $param > /dev/null 2>&1 &
      sleep 1
    done
  ;;
  *)
    echo "Wrong action specified("$action")"
    exit 1
  ;;
esac

