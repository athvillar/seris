#!/bin/bash
#set -x

basepath=`dirname $0`"/.."
srcpath=$basepath/src

$srcpath/invoke.sh meta0 10 10 0 findnode $1
