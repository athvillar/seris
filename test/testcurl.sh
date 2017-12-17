#!/bin/bash
#set -x

basepath=`dirname $0`"/.."
srcpath=$basepath/src

$srcpath/invoke.sh meta0 10 10 ALL curl.sh http://haiboy123.qy6.com
#$srcpath/invoke.sh meta0 dispatch ping.sh www.baidu.com
