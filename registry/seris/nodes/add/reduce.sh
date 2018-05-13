#!/bin/bash
#set -x

# _pre_process: process before loop
function _pre_process() {
  sum=",,"
}

# _process: process in loop
# $_line: result from run.sh
function _process() {
  sum="$sum:$_line"
}

# _post_process: process after loop
function _post_process() {
  echo $sum
}
