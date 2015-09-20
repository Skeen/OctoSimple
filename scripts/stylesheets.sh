#!/bin/bash
# Handling includes from stylesheets.jinja2

TREE_DIR=$1
source scripts/jinja-assets.sh

# Handle CSS assets
assets css_libs css/ output_css $TREE_DIR
echo ""
assets less_app less/ output_less $TREE_DIR
echo ""

# TODO: Handle ?? CSS APP ?? assets ??

echo "<script src=\"js/lib/less.min.js\" type=\"text/javascript\"></script>"
echo ""

