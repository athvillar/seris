#!/bin/bash
#set -x

# _pre_process: process before loop
function _pre_process() {
  msg=""
}

# _process: process in loop
# $_line: result from run.sh
function _process() {
  msg=$_line
}

# _post_process: process after loop
function _post_process() {
  echo $msg
}
