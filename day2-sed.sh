#!/usr/bin/env bash

# Okay, so this isn't just using sed, it also uses bash, but that is only so that the output of the first sed command
# (which is a bunch more sed commands) can be run

# each line of input is rewritten as a sed command which will either print the valid password of omit the line
# the those are run, then the lines are enumerated, then the last line is printed

<day2-input.txt \
  sed 's/\([0-9]*\)-\([0-9]*\) \(.\): \(.*\)/sed -e "\/^[^\3]*\\(\3[^\3]*\\)\\{\1,\2\\}$\/q" -e "\/.\/d" <<< "\4"/' \
  | bash \
  | sed -e /./= -e /./d \
  | sed -n '$p'
