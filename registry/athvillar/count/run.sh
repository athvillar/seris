#!/bin/bash

n=1000
#sum2=0
#for((idx=1;idx<=9;idx++)); do
sum=0
for((i=1;i<=n;i++)); do
  sum=`expr $sum + $i`
done
#sum2=`expr $sum2 + $sum`
#done
echo $sum
#echo $sum2
exit 0
