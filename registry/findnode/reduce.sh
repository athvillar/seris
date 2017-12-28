#!/bin/bash
#set -x

# _pre_process: process before loop
function _pre_process() {
  _=0
}

# _process: process in loop
# $_line: result from run.sh
function _process() {
  if [ "$_line" != "" ]; then
    echo $_line
    break
  fi
}

# _post_process: process after loop
function _post_process() {
  _=0
}
