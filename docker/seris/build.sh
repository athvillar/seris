#!/bin/bash

basedir=`dirname $0`
cd $basedir

rm -rf resource/seris
mkdir -p resource/seris
cp -r ../../../seris/src resource/seris/
cp -r ../../../seris/registry resource/seris/
cp -r ../../../seris/work resource/seris/
cp -r ../../../seris/run.sh resource/seris/
docker build -t athvillar/seris .

