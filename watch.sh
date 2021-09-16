#!/bin/sh

inode_to_watch=$1
command_to_run=$2
lastRunTime=$(date +'%H%M%S')

eval "$command_to_run &"
pid=$!

inotifywait -q -m -e modify $inode_to_watch |
while read -r filename event; do
    currentTime=$(date +'%H%M%S')
    delta=$(expr $currentTime - $lastRunTime)

    if [ "$delta" != "0" ]; then
        kill -15 $pid 2>/dev/null;
        while ps | awk '{ print $1 }' | grep -w "$pid" > /dev/null 2>&1; do sleep 1; done
        eval "$command_to_run &"
        pid=$!
        lastRunTime=$(date +'%H%M%S')
    fi
done