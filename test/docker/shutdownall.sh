#!/bin/bash

function killprocess() {
  for pid in `ps -eaf | grep "$1" | awk '{ print $2 }'`; do
    if [ $$ != $pid ]; then
      kill $pid
    fi
  done
}

killprocess listener.sh
#killprocess ping
#killprocess curl
killprocess "nc -l"
