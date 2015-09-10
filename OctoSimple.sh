#!/bin/bash

# Get the source
git clone https://github.com/Skeen/OctoPrint.git

# Remove the junk
rm OctoPrint/*
rm -rf OctoPrint/docs
rm -rf OctoPrint/scripts
rm -rf OctoPrint/tests
rm -rf OctoPrint/translations
rm -rf OctoPrint/src/octoprint_setup_tools
rm -rf OctoPrint/src/octoprint/filemanager
rm -rf OctoPrint/src/octoprint/plugin
rm -rf OctoPrint/src/octoprint/plugins
rm -rf OctoPrint/src/octoprint/printer
rm -rf OctoPrint/src/octoprint/server
rm -rf OctoPrint/src/octoprint/slicing
rm -rf OctoPrint/src/octoprint/translations
rm -rf OctoPrint/src/octoprint/util
rm OctoPrint/src/octoprint/*

# Prepare the OctoSimple directory
mkdir -p OctoSimple
mv OctoPrint/src/octoprint/static/* OctoSimple
mv OctoPrint/src/octoprint/templates/* OctoSimple
