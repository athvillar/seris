function randn() {
  str="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  rst=""
  for line in `seq 0 $1`; do
    num1=`expr $RANDOM % 36`
    rst=$rst${str:$num1:1}
  done
  echo $rst
}

function get_linked_node_list() {
  if [ "$SERIS_META_PATH" != "" -a -d $SERIS_META_PATH ]; then
    cat $SERIS_META_PATH/node_list
  else
    echo {SERIS_LINKED_NODE//:/ }
  fi
}
