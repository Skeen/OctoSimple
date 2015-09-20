#!/bin/bash

function find_assets {
    ASSET_FOLDER=$1
    PREFIX=$2
    for f in $(ls -p $PREFIX$1 | grep -v /); do
        echo $1$f
    done
    for d in $(ls -p $PREFIX$1 | grep /); do
        find_assets $1$d $2
    done
}

find_assets $1 $2
