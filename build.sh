#!/bin/bash

CURRENT_DIR=$(pwd)

CMAKE_LISTS_DIR=$CURRENT_DIR/project/blinky
CMAKE_LISTS_BLD_DIR=$CURRENT_DIR/build

rm -r $CMAKE_LISTS_BLD_DIR/*

mkdir $CMAKE_LISTS_BLD_DIR/cmakelists -p

cd $CMAKE_LISTS_BLD_DIR/cmakelists && 
cmake $CMAKE_LISTS_DIR
