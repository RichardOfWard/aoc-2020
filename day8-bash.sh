#!/usr/bin/env bash
set -euf -o pipefail

state=$(./machine/build-state.sh day8-input.txt)

declare -A opNums
declare -A opNumsFromFirstRun

while true ; do
  nextOpNum=$(echo "$state" | grep -E '^nextOpNum' | grep -Eo "[0-9]+")
  if [ "${opNums[$nextOpNum]+seen}" == seen ] ; then
    echo "$state" | grep accumulator | grep -Eo "[0-9]+"
    break
  fi
  opNums[$nextOpNum]=seen
  opNumsFromFirstRun[$nextOpNum]=seen
  state=$(echo "$state" | ./machine/advance.sh)
done

rawState=$(./machine/build-state.sh day8-input.txt)
totalOps=$(wc -l day8-input.txt|grep -Eo "^[0-9]*")
found=0

for opNum in "${!opNumsFromFirstRun[@]}"; do
  unset opNums
  declare -A opNums
  state=$(echo "$rawState"  \
    | sed "s,\(op$opNum:\)jmp,\1XXX," \
    | sed "s,\(op$opNum:\)nop,\1jmp," \
    | sed "s,\(op$opNum:\)XXX,\1nop,"
  )
  while true ; do
    nextOpNum=$(echo "$state" | grep -E '^nextOpNum' | grep -Eo "[0-9]+")
    if [ "${opNums[$nextOpNum]+seen}" == seen ] ; then
      break
    fi
    if [ "$nextOpNum" -gt "$totalOps" ] ; then
      found=1
      break
    fi
    opNums[$nextOpNum]=seen
    state=$(echo "$state" | ./machine/advance.sh)
  done
  if [ "$found" == "1" ] ; then
    echo "$state" | grep accumulator | grep -Eo "[0-9]+"
    break
  fi
done
