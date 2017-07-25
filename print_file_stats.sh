#!/bin/bash

if [[ $# -eq 0 ]] ; then
  echo
  echo 'Usage: print_file_stats <filename>'
  echo
  echo 'The file must contain two lines with the format:'
  echo '  ... START COUNTING'
  echo '  and'
  echo '  ... END COUNTING'
  echo 'in this order.'
  echo
  exit 0
fi

FILENAME=$1
RUBY_CODE="require '/home/wolf/workspace/codegolf/test_utils.rb'; print_size_stats('$FILENAME')"
COMMAND="ruby -e \"$RUBY_CODE\""

eval $COMMAND

