#!/bin/bash
#set -x

basepath=`dirname $0`"/.."
srcpath=$basepath/src

<<<<<<< HEAD
$srcpath/invoke.sh meta 10 20 ALL ping "www.baidu.com 1"
=======
$srcpath/invoke.sh meta0 10 20 ALL ping "www.baidu.com 4"
#echo "00000001 ODR seris_n 120.195.162.120 1179 0000007 10 10 10 ALL ping www.baidu.com 1" | nc 172.17.0.16 1179
>>>>>>> a72145657fd740bd5b3025304012d54958d8c0c9
