#!/usr/bin/env bash

<day4-input.txt awk 'BEGIN {RS="\n\n"}{if($0~/(:.*){8}/||($0~/(:.*){7}/&&$0!~/cid:/))a++;}END{print a}'
