#!/bin/bash
#set -x

thispath=`dirname $0`
SERIS_HOME=$thispath/../..
source $thispath/common.sh

function init() {
  container_list=$thispath/container_list
  if [ -f $container_list ]; then
    rm $container_list
  fi
  cport=1179
}

function get_params() {
  if [ $# != 1 ]; then
    echo "Usage: $0 [Number of Nodes]"
    exit -1
  fi
  node_num=$1
}

function make_nodes() {
  for ((i=0; i<$node_num; i++)); do
    cname="seris_n$i"
    cid=`run_container_1 $cname`
    if [ "$cid" = "" ]; then
      continue
    fi
    cip=`docker inspect $cid | grep "\"IPAddress\"" | head -1 | awk -F : '{ print $2 }' | sed 's/[", ]//g'`
    echo "$cid,$cname,$cip" >> $container_list
  done
}

function configure_nodes() {
  #for line in `cat $container_list`; do
  for ((i=0; i<$node_num; i++)); do
    #cid=`echo $line | awk -F , '{ print $1 }'`
    #cname=`echo $line | awk -F , '{ print $2 }'`
    #cip=`echo $line | awk -F , '{ print $3 }'`

    #docker cp $SERIS_HOME $cid:/usr/local/
    # meta/selfnode
    #rm -rf $thispath/meta
    #mkdir -p $thispath/meta
    #echo $cname,$cip,$cport > $thispath/meta/selfnode

    # meta/nodelist
    friend_num=`get_friends_num $node_num`
    for node_index in `echo $node_num $friend_num | awk 'BEGIN{ srand() }{for(i=1;i<=$2;i++) printf("%g ", int($1 * rand()) + 1) }'`; do
      line2=`cat $container_list | sed -n "${node_index}p"`
      conn_node_name=`echo $line2 | awk -F , '{ print $2 }'`
      conn_node_ip=`echo $line2 | awk -F , '{ print $3 }'`
      conn_node_port=$cport
      if [ "$conn_node_name" = "$cname" ]; then
        continue
      fi
      conn_node_in_list=`echo $SERIS_LINKED_LIST | grep $conn_node_name`
      if [ "$conn_node_in_list" != "" ]; then
        continue
      fi
      #echo $conn_node_name,$conn_node_ip,$conn_node_port >> $thispath/meta/nodelist
      SERIS_LINKED_LIST=$SERIS_LINKED_LIST:$conn_node_name,$conn_node_ip,$conn_node_port
    done

    # meta/env
    #echo "export SERIS_NODEID="$cname > $thispath/meta/env
    #echo "export SERIS_HOST="$cip >> $thispath/meta/env
    #echo "export SERIS_PORT="$cport >> $thispath/meta/env
    #docker cp $thispath/meta $cid:/usr/local/seris/

    #cname="seris_n$i"
    #cid=`run_container_1`
    #if [ "$cid" = "" ]; then
    #  continue
    #fi
    #cip=`docker inspect $cid | grep "\"IPAddress\"" | head -1 | awk -F : '{ print $2 }' | sed 's/[", ]//g'`
    #docker exec -it $SERIS_HOME/src/invoke.sh $SERIS_HOST $SERIS_PORT seris/addenv SERIS_NODEID $cid
    #docker exec -it $SERIS_HOME/src/invoke.sh $SERIS_HOST $SERIS_PORT seris/addenv SERIS_HOST $cip
    #docker exec -it $SERIS_HOME/src/invoke.sh $SERIS_HOST $SERIS_PORT seris/addenv SERIS_PORT $cport
    #docker exec -it $SERIS_HOME/src/invoke.sh $SERIS_HOST $SERIS_PORT seris/addenv SERIS_LINKED_LIST $SERIS_LINKED_LIST
    #echo "$cid,$cname,$cip" >> $container_list
  done
}

function start_nodes() {
  for line in `cat $container_list`; do
    cid=`echo $line | awk -F , '{ print $2 }'`
    docker exec $cid /usr/local/seris/src/listener.sh meta &
  done
}

get_params $*
init
make_nodes
configure_nodes
start_nodes

