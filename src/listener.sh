#!/bin/bash
#set -x

export basepath=`dirname $0`/..
export srcpath=$basepath/src
export registrypath=$basepath/registry

meta=$1
if [ "$meta" = "" ]; then
  echo "No meta folder specified, take 'meta' as default."
  meta="meta"
fi

port=`cat $basepath/$meta/selfnode | awk -F , '{ print $3 }'`
while true; do
  rtn=`nc -l $port`
  $srcpath/controller.sh $meta $rtn &
done

