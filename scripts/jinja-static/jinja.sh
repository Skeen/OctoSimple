#!/bin/bash

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
WORK_DIR=tmp
TEMPLATES_DIR=$WORK_DIR/OctoPrint/src/octoprint/templates
STATIC_DIR=$WORK_DIR/OctoPrint/src/octoprint/static
INDEX_FILE=$TEMPLATES_DIR/index.jinja2

# --------------------------------------------------------- #
# Handle all includes
# --------------------------------------------------------- #
REPLACE_TAG="{% include '.*' %}"
while read line; do
    INCLUDE=$(echo $line | grep -o "$REPLACE_TAG" | grep -o "'.*'")
    if [ -n "$INCLUDE" ]; then
        INCLUDE_FILE=${INCLUDE:1:-1}
        cat $TEMPLATES_DIR/$INCLUDE_FILE
    else
        echo $line
    fi
done <$INDEX_FILE > $WORK_DIR/included.tmp

# --------------------------------------------------------- #
# Handle assets
# --------------------------------------------------------- #
# Generate resources map
mkdir -p res_map
FIND_ASSETS=$SCRIPT_DIR/find_assets.sh
$FIND_ASSETS js/lib/ $STATIC_DIR/ > res_map/js_libs
$FIND_ASSETS js/app/ $STATIC_DIR/ > res_map/js_app
$FIND_ASSETS css/ $STATIC_DIR/ > res_map/css_libs
$FIND_ASSETS less/ $STATIC_DIR/ > res_map/less_aps
echo "" > res_map/css_app
echo "" > res_map/less_app

# Replace all assets tags
REPLACE_TAG="{% assets ".*" %}"
while read line; do
    ASSETS=$(echo $line | grep -o "$REPLACE_TAG" | grep -o "\".*\"")
    ASSETS_END=$(echo $line | grep -o "{% endassets %}")

    if [ -n "$ASSETS" ]; then
        ASSETS_NAME=${ASSETS:1:-1}
    else if [ -n "$ASSETS_END" ]; then
        ASSETS_NAME=""
    else if [ -n "$ASSETS_NAME" ]; then
        while read resource; do
            ESCAPE_RESOURCE=$(echo $resource | sed 's/\//\\\ \//g' | sed 's/ //g')
            echo $line | sed "s/{{ ASSET_URL }}/$ESCAPE_RESOURCE/"
        done <res_map/$ASSETS_NAME
    else
        echo $line
    fi fi fi
done <$WORK_DIR/included.tmp > $WORK_DIR/assets.tmp

# --------------------------------------------------------- #
# Handle url_for
# --------------------------------------------------------- #
sed "s/{{ url_for('static', filename='\(.*\)') }}/\1/g" $WORK_DIR/assets.tmp > $WORK_DIR/urlfor.tmp



