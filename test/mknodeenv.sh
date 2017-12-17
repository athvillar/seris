#!/bin/bash
#set -x

basepath=`dirname $0`"/.."
srcpath=$basepath/src

i=0
for line in `cat $basepath/test/nodelist`; do
  rm -rf $basepath/meta$i
  mkdir $basepath/meta$i
  echo $line > $basepath/meta$i/selfnode
  selfNodeId=`echo $line | awk -F , '{ print $1 }'`
  selfNodeHost=`echo $line | awk -F , '{ print $2 }'`
  selfNodePort=`echo $line | awk -F , '{ print $3 }'`
  for line2 in `cat $basepath/test/nodemap | grep "$selfNodeId,"`; do
    connNodeId=`echo $line2 | awk -F , '{ print $2 }'`
    connNodePort=`cat $basepath/test/nodelist | grep "$connNodeId," | awk -F , '{ print $3 }'`
    echo $connNodeId",localhost,"$connNodePort >> $basepath/meta$i/nodelist
  done
  echo "export selfNodeId="$selfNodeId > $basepath/meta$i/env
  echo "export selfNodeHost="$selfNodeHost >> $basepath/meta$i/env
  echo "export selfNodePort="$selfNodePort >> $basepath/meta$i/env
  echo "export monitorwaittime=2" >> $basepath/meta$i/env
  $srcpath/listener.sh meta$i &
  i=`expr $i + 1`
done
