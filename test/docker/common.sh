function run_container_1() {
  cid=`nvidia-docker run \
    --name $1 \
    -h $1 \
    -d \
    -it \
    --rm \
    -v /etc/localtime:/etc/localtime \
    nc:latest`
  echo $cid
}

function get_friends_num() {
  rand_num=$RANDOM
  middle=`echo $1 | awk '{ printf("%g", int(sqrt($1)))}'`
  if [ $rand_num -lt 100 ]; then
    rtn=`expr $middle / 8`
  elif [ $rand_num -lt 1000 ]; then
    rtn=`expr $middle / 4`
  elif [ $rand_num -lt 10000 ]; then
    rtn=`expr $middle / 2`
  elif [ $rand_num -lt 22700 ]; then
    rtn=$middle
  elif [ $rand_num -lt 31700 ]; then
    rtn=`expr $middle \* 2`
  elif [ $rand_num -lt 32660 ]; then
    rtn=`expr $middle \* 4`
  else
    rtn=`expr $middle \* 8`
  fi
  rtn=`echo $rtn | awk '{srand(); printf("%g",  int((1 + rand()  0.5) * $1)) }'`
  if [ $rtn -gt $1 ]; then
    rtn=$1
  fi
  echo $rtn
}
