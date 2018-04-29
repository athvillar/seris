#!/bin/bash
#set -x

basepath=`dirname $0`"/.."
srcpath=$basepath/src

if [ $# -lt 2 ]; then
  echo "Usage: $0 [target ip] [target_port] [registry] [params]"
  exit 99
fi

target_ip=$1
target_port=$2
shift 2

case "$1" in
  drawnet)
    $srcpath/invoke.sh $target_ip $target_port drawnet
  ;;
  count)
    $srcpath/invoke.sh $target_ip $target_port count
  ;;
  countnode)
    $srcpath/invoke.sh $target_ip $target_port countnode
  ;;
  curl)
    $srcpath/invoke.sh $target_ip $target_port curl.sh http://haiboy123.qy6.com
  ;;
  findnode)
    $srcpath/invoke.sh $target_ip $target_port findnode $2
  ;;
  ping)
    $srcpath/invoke.sh $target_ip $target_port ping "www.baidu.com 4"
  ;;
  sendmsg)
    node=$2
    shift 2
    $srcpath/invoke.sh $target_ip $target_port sendMsg "$node $*"
  ;;
esac

