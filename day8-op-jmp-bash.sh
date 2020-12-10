#!/usr/bin/env bash
set -euf -o pipefail

# read program state
state=$(cat)

# find out the adjustment (e.g. +12)
adjustment=$(echo "$1" | grep -Eo '[-+][0-9]+')

# find the current value
oldValue=$(echo "$state" | grep -E "^nextOpNum:" | grep -Eo '[0-9]+')

# calculate the new value
newValue=$(("$oldValue" + "$adjustment" - 1)) # subtract one as this is the *next* op we are changing
state=$(echo "$state" | sed "s,^nextOpNum:$oldValue,nextOpNum:$newValue,")

echo "$state"
