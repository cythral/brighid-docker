#!/bin/sh

inode_to_watch=$1
command_to_run=$2

$command_to_run &
pid=$!

inotifywait -q -m -e close_write $inode_to_watch |
while read -r filename event; do
    while kill -0 $pid 2>/dev/null; do sleep 1; done;
    $command_to_run &
    pid=$!
done