#!/usr/bin/env bash
set -euf -o pipefail

state=$(./machine/build-state.sh day8-input.txt)

declare -A opNums

while true ; do
  nextOpNum=$(echo "$state" | grep -E '^nextOpNum')
  if [ "${opNums[$nextOpNum]+seen}" == seen ] ; then
    echo "$state" | grep accumulator | grep -Eo "[0-9]+"
    exit 0
  fi
  opNums[$nextOpNum]=seen
  state=$(echo "$state" | ./machine/advance.sh)
done