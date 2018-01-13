#!/bin/bash
#set -x

basepath=`dirname $0`"/.."
srcpath=$basepath/src
meta="meta-1"

case "$1" in
  drawnet)
    $srcpath/invoke.sh $meta drawnet
  ;;
  count)
    $srcpath/invoke.sh $meta count
  ;;
  countnode)
    $srcpath/invoke.sh $meta $meta countnode
  ;;
  curl)
    $srcpath/invoke.sh $meta $meta curl.sh http://haiboy123.qy6.com
  ;;
  findnode)
    $srcpath/invoke.sh $meta findnode $2
  ;;
  ping)
    $srcpath/invoke.sh $meta ping "www.baidu.com 4"
  ;;
  sendmsg)
    node=$2
    shift 2
    $srcpath/invoke.sh $meta sendMsg "$node $*"
  ;;
esac

