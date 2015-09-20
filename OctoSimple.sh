#!/bin/bash

BUILD_DIR=build
WORK_DIR=tmp
DEBUG=true

mkdir -p $BUILD_DIR
mkdir -p $WORK_DIR

# Setup the work dir environment
cd $WORK_DIR

# Get the source
git clone https://github.com/Skeen/OctoPrint.git 

# Remove the junk
rm OctoPrint/*
rm -rf OctoPrint/.*
rm -rf OctoPrint/docs
rm -rf OctoPrint/scripts
rm -rf OctoPrint/tests
rm -rf OctoPrint/translations
rm -rf OctoPrint/src/octoprint_setuptools
rm -rf OctoPrint/src/octoprint/filemanager
rm -rf OctoPrint/src/octoprint/plugin
rm -rf OctoPrint/src/octoprint/plugins
rm -rf OctoPrint/src/octoprint/printer
rm -rf OctoPrint/src/octoprint/server
rm -rf OctoPrint/src/octoprint/slicing
rm -rf OctoPrint/src/octoprint/translations
rm -rf OctoPrint/src/octoprint/util
rm OctoPrint/src/octoprint/*

# Return to the root dir
cd ..

# Prepare the OctoSimple directory
mv $WORK_DIR/OctoPrint/src/octoprint/static/* $BUILD_DIR
#mv OctoPrint/src/octoprint/templates/* $BUILD_DIR

# Assert we got everything
FILES_LEFT=$(find $BUILD_DIR/OctoPrint/ -type f)
# TODO: ADD CHECK

# Start converting
SNIPPETS_DIR=$WORK_DIR/snippets
mkdir -p $SNIPPETS_DIR

TEMPLATES_DIR=$WORK_DIR/OctoPrint/src/octoprint/templates

STYLESHEETS_JINJA=$TEMPLATES_DIR/stylesheets.jinja2
./scripts/stylesheets.sh $BUILD_DIR > $SNIPPETS_DIR/stylesheets.snip
rm $STYLESHEETS_JINJA

# TODO: improve this
INITSCRIPT_JINJA=$TEMPLATES_DIR/initscript.jinja2
cp res/initscript.snip $SNIPPETS_DIR/initscript.snip
rm $INITSCRIPT_JINJA

JAVASCRIPTS_JINJA=$TEMPLATES_DIR/javascripts.jinja2
./scripts/javascrips.sh $BUILD_DIR > $SNIPPETS_DIR/javascripts.snip
rm $JAVASCRIPTS_JINJA

./scripts/index-process.sh
cp $WORK_DIR/index.html $BUILD_DIR

# ... and apply the changes

