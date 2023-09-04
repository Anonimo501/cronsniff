#!/bin/bash

old=$(ps -eo command)
filter="kworker|command|defunct"

function ctrl_c(){
  exit 1
}

trap ctrl_c int

while true; do
  new=$(ps -eo command)
  diff <(echo "$old") <(echo "$new") | grep "[\>\<]" | grep -vE "$filter"
  old=$new
done