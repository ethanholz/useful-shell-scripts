#!/bin/bash
while getopts s:n:r: flag
do
    case "${flag}" in
        s) start=${OPTARG} ;;
        n) number=${OPTARG} ;;
        r) repo=${OPTARG} ;;
    esac
done
for i in $( seq $start $number )
do
    gh issue view $i > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        echo "Found issue #$i"
        gh issue transfer $i $repo 2>&1
        echo "Transferred issue #$i"
    fi
    sleep 1s
done

