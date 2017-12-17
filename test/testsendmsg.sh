#!/bin/bash
#set -x

basepath=`dirname $0`"/.."
srcpath=$basepath/src

node=$1
shift 1
$srcpath/invoke.sh meta0 10 10 0 sendMsg "$node $*"
