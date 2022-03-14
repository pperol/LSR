#!/bin/bash

while getopts sc opt; do
    case $opt in
        s)
            silent=true
            ;;
        c)
            convert=true
            ;;
    esac
done
param=$ 
if [ $silent ]; then
    param=${param:3}
fi
if [ $convert ]; then
    param=${param:3}
fi
filter=${param:-"*.ly"}

for LILYFILE in $filter
do
    STEM=$(basename "$LILYFILE" .ly)
    if [ $convert ]; then
        if [ $silent ]; then
            $LILYPOND_BUILD_DIR/convert-ly -e "$LILYFILE" &> "$STEM".con.txt
        else
            $LILYPOND_BUILD_DIR/convert-ly -e "$LILYFILE"
        fi
    fi
    if [ ! $silent ]; then
        echo "running $LILYFILE..."
    fi
    $LILYPOND_BUILD_DIR "$LILYFILE" &> "$STEM".txt
    RetVal=$?
    if [ $RetVal -gt 0 ]; then
       echo "$LILYFILE failed"
    fi
done
