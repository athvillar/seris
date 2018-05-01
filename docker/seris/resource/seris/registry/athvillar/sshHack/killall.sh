#!/bin/bash

for pid in `ps -aef | grep sshHack | awk '{ print $2 }'`; do
  if [ $pid != $$ ]; then
    kill $pid
  fi
done

