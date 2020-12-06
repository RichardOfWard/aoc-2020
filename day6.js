#!/usr/bin/env -S bash -c '<day6-input.txt node $1' --
console.log(eval(require('fs').readFileSync(0,'utf8').split('\n\n').map(g=>new Set(g.replace(/\s/g,'')).size).join("+")))
console.log(eval(require('fs').readFileSync(0,'utf8').split('\n\n').map(g=>[...g.split('\n').reduce((l,r)=>[...l].filter(l=>r.indexOf(l)>=0))].length).join("+")))