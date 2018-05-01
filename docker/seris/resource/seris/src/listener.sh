#!/bin/bash
#set -x

pipefile=$SERIS_WORK_PATH/ff-$$
mkfifo $pipefile
exec 6<>$pipefile
rm -f $pipefile
nc -lk $SERIS_HOST $SERIS_PORT >&6 &
while read line <&6; do
  $SERIS_SRC_PATH/controller.sh $line &
done

