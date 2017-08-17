#!/bin/sh

# set -e

FILE="139335-generate-unseen-numbers.hs"

while true; do
  inotifywait -e MODIFY $FILE
  clear
  time stack runghc $FILE && ../print_file_stats.sh $FILE
done

