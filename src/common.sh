function randn(){
  str="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  rst=""
  for ((i=0;i<$1;i++)); do
    num1=`expr $RANDOM % 36`
    rst=$rst${str:$num1:1}
  done
  echo $rst
}
