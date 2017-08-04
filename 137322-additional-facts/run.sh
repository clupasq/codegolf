#!/bin/sh

# set -e

FILE="137322-additional-facts_golfed.hs"

while true; do
  inotifywait -e MODIFY $FILE
  clear
  time stack runghc $FILE && ../print_file_stats.sh $FILE
done

