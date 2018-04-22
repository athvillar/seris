function randn(){
  str="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  rst=""
  for `seq 0 $1`; do
    num1=`expr $RANDOM % 36`
    rst=$rst${str:$num1:1}
  done
  echo $rst
}
