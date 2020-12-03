#!/usr/bin/env bash

# Okay, so this isn't just using sed, it also uses bash, but that is only so that the output of the first sed command
# (which is a bunch more sed commands) can be run.
# I think this maybe could be done using the `e` command in sed but I'm not sure

# each line of input is rewritten as a sed command which will either print the valid password of omit the line
# the those are run, then the lines are enumerated, then the last line is printed
<day2-input.txt \
  sed 's/\([0-9]*\)-\([0-9]*\) \(.\): \(.*\)/sed -e "\/^[^\3]*\\(\3[^\3]*\\)\\{\1,\2\\}$\/q" -e "\/.\/d" <<< "\4"/' \
  | bash \
  | sed -e /./= -e /./d \
  | sed -n '$p'


# for day 2, print the password twice, prefixed with a - (zero indexing it) separated by a ! so we can search in both
# password-prints for the relevant char. If we find both, we delete, then if we find one or the other we print, else
# delete
<day2-input.txt \
  sed 's/\([0-9]*\)-\([0-9]*\) \(.\): \(.*\)/sed -e "\/^.\\{\1\\}\3.*!.\\{\2\\}\3\/d" -e "\/^.\\{\1\\}\3\/p" -e "\/^.\\{\2\\}\3\/p" -e "\/.\/d" <<< "-\4!-\4"/' \
  | bash \
  | sed -e /./= -e /./d \
  | sed -n '$p'
