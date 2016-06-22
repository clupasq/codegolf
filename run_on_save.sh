#!/bin/sh

HELP_COMMAND="--help"


FIRST_ARG=${1:-$HELP_COMMAND}

if [ "$FIRST_ARG" = $HELP_COMMAND ];
then
  echo Help...
  echo
  echo "USAGE:"
  echo
  echo "  run_on_save <file_name> [<command_to_run>]"
  echo
  echo "ARGUMENTS:"
  echo
  echo "  <file_name> (mandatory): The file to listen for changes"
  echo "  <command_to_run> (optional): The command to run when the file changes"
  echo "          If not specified, it defaults to: ruby <file_name>"
  echo
  echo "PREREQUISITES:"
  echo
  echo "  inotify-tools must be installed, as this uses inotifywait to listen for file changes."
  echo
  exit
fi

FILE_NAME=$FIRST_ARG
RUN_COMMAND=${2:-"ruby $FILE_NAME"}

echo "Every time $FILE_NAME is saved, the following command will be run:"
echo
echo "    $RUN_COMMAND"
echo
echo
echo "Press CTRL+C to interrupt..."
echo

while inotifywait -e MODIFY $FILE_NAME;
do
  clear
  eval $RUN_COMMAND
done



