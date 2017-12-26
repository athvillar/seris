#!/bin/bash

thispath=`dirname $0`

function init() {
  SERIS_HOME=$thispath/../..
  source $thispath/common.sh
  container_list=$thispath/container_list
  rm $container_list
  cport=1179
}

function get_params() {
  node_num=$1
}

function make_nodes() {
  for ((i=0; i<$node_num; i++)); do
    cname="seris_n$i"
    cid=`run_container_1 $cname`
    cip=`docker inspect ubuntu1604 | grep "\"IPAddress\"" | head -1 | awk -F : '{ print $2 }' | sed 's/[", ]//g'`
    echo "$cid,$cname,$cip" >> $container_list
  done
}

function configure_nodes() {

  for line in `cat $container_list`; do
    cname=`echo $line | awk -F , '{ print $1 }'`
    cid=`echo $line | awk -F , '{ print $2 }'`
    cip=`echo $line | awk -F , '{ print $3 }'`

    docker cp $SERIS_HOME $cid:/usr/local/

    # meta/selfnode
    rm -rf $thispath/meta
    mkdir -p $thispath/meta/work
    echo $cname,$cip,$cport > $thispath/meta/selfnode

    # meta/nodelist
    friend_num=`get_friends_num $node_num`
    for ((i=0; i<$friend_num; i++)); do
      node_index=`awk '{ srand(); printf("%g", int($1 * rand())) }'`
      line2=`cat $container_list | sed -n "${node_index}p"`
      conn_node_name=`echo $line2 | awk -F , '{ print $2 }'`
      conn_node_ip=`echo $line2 | awk -F , '{ print $3 }'`
      conn_node_port=$cport
      echo $conn_node_name,$conn_node_ip,$conn_node_port >> $thispath/meta/nodelist
    done

    # meta/env
    echo "export SERIS_NODEID="$cname > $thispath/meta/env
    echo "export SERIS_HOST="$cip >> $thispath/meta/env
    echo "export SERIS_PORT="$cport >> $thispath/meta/env
    echo "export monitorwaittime=2" >> $thispath/meta/env

    docker cp $thispath/meta $cid:/usr/local/seris/
  done
}

function start_nodes() {
  for line in `cat $container_list`; do
    cid=`echo $line | awk -F , '{ print $2 }'`
    docker exec -it $cid /usr/local/seris/src/listener.sh meta
  done
}

get_params
make_nodes
configure_nodes
start_nodes

