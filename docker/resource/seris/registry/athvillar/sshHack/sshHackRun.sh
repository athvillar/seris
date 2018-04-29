#!/bin/bash

basepath=`dirname $0`
cmdname=`basename $0`

if [ $# != 1 ]; then
  echo "Usage: $cmdname [node number]"
  exit 99
fi
source $basepath/sshHackEnv.sh
nodenumber=$1

linenum=`wc -l $dicfile | awk '{ print $1 }'`
wordspernode=`expr \( $linenum - 1 \) / $nodenumber + 1`

for ((i=0;i<$nodenumber;i++)); do
  start=`expr 1 + $i \* $wordspernode`
  end=`expr $start + $wordspernode - 1`
  echo $i $start $end
  $basepath/sshHackProcess.sh $i $start $end &
done
