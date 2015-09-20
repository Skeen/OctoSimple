#!/bin/bash

function assets_worker {
    ASSET_FOLDER=$1
    FUNCTION=$2
    PREFIX=$3
    for f in $(ls -p $PREFIX$1 | grep -v /); do
        $FUNCTION $1$f
    done
    for d in $(ls -p $PREFIX$1 | grep /); do
        assets_worker $1$d $2 $3
    done
}

function assets {
    ASSET_NAME=$1
    echo "<!-- assets \"$ASSET_NAME\" -->"
    assets_worker $2 $3 $4
}

function output_js {
    echo "<script type=\"text/javascript\" src=\"$1\"></script>"
}

function output_css {
	echo "<link href=\"$1\" rel=\"stylesheet\" media=\"screen\">"
}

function output_less {
    echo "<link href=\"$1\" rel=\"stylesheet/less\" type=\"text/css\" media=\"screen\">"
}


