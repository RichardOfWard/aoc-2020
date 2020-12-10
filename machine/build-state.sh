#!/usr/bin/env bash
set -euf -o pipefail

echo nextOpNum:1
echo accumulator:0

awk '{print "op" NR ":" $0}' "$1"
