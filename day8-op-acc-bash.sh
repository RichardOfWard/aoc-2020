#!/usr/bin/env bash
set -euf -o pipefail

# read program state
state=$(cat)

# find out the adjustment (e.g. +12)
adjustment=$(echo "$1" | grep -Eo '[-+][0-9]+')

# find the current value
oldValue=$(echo "$state" | grep -E "^accumulator:" | grep -Eo '[0-9]+')

# calculate the new value
newValue=$(("$oldValue" + "$adjustment"))
state=$(echo "$state" | sed "s,^accumulator:$oldValue,accumulator:$newValue,")

echo "$state"
