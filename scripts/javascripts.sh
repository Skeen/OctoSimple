#!/bin/bash
# Handling includes from stylesheets.jinja2

TREE_DIR=$1
source scripts/jinja-assets.sh

# Handle js_libs assets
assets js_libs js/lib/ output_js $TREE_DIR
echo ""

assets js_app js/app/ output_js $TREE_DIR
echo ""

# TODO: Handle {% if g.locale %}
