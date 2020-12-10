#!/usr/bin/env bash
set -euf -o pipefail

# read program state
state=$(cat)

# advance the program calculator
opNum=$(echo "$state" | grep -E "^nextOpNum:" | grep -Eo '[0-9]+')
nextOpNum=$(( "$opNum" + 1 ))
state=$(echo "$state" | sed "s,^nextOpNum:$opNum,nextOpNum:$nextOpNum,")

# find the next operation
op=$(echo "$state" | grep -E "^op$opNum:" | sed "s,^op$opNum:,,")
opCode=$(dirname $0)/operations/$(echo "$op" | sed "s, .*,,")

# run the operation, passing in state
state=$(echo "$state" | "$opCode" "$op")

# output the new state
echo "$state"