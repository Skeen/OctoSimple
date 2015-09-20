#!/bin/bash

INDEX_FILE=tmp/OctoPrint/src/octoprint/templates/index.jinja2
OUTPUT_FILE=tmp/index.html

function inject {
    REPLACE_TAG="{% include '$1.jinja2' %}"
    INJECT_FILE="tmp/snippets/$1.snip"
    sed -e "/$REPLACE_TAG/ {" -e "r $INJECT_FILE" -e "d" -e "}" -i $OUTPUT_FILE
}

cp $INDEX_FILE $OUTPUT_FILE

sed "s/{{ url_for('static', filename='\(.*\)') }}/\1/g" -i $OUTPUT_FILE

inject stylesheets
inject initscript
inject javascripts
