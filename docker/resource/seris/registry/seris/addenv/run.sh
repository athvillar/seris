#!/bin/bash

envname=$1
envvalue=$2

if [ "$envvalue" != "" ]; then
  export $envname=$envvalue
fi
