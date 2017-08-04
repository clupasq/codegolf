#!/bin/sh

# set -e

FILE="137465-when-do-the-lights-blink_golfed.hs"

while true; do
  inotifywait -e MODIFY $FILE
  clear
  time stack runghc $FILE && ../print_file_stats.sh $FILE
done

