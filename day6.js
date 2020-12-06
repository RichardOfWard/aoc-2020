#!/usr/bin/env -S bash -c '<day6-input.txt node $1' --
i=require('fs').readFileSync(0,'utf8')
f=c=>console.log(eval(i.split('\n\n').map(c).join('+')))
f(g=>new Set(g.replace(/\s/g,'')).size)
f(g=>[...g.split('\n').reduce((l,r)=>[...l].filter(l=>r.indexOf(l)+1))].length)