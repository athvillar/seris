#!/bin/bash

basedir=`dirname $0`
cd $basedir

docker build -t athvillar/seris:base .

