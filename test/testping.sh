#!/bin/bash
#set -x

basepath=`dirname $0`"/.."
srcpath=$basepath/src

$srcpath/invoke.sh meta0 10 20 ALL ping "www.baidu.com 8"
