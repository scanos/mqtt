#!/bin/bash
test=$(tail -1 ~/rainfall)
test=$(echo ${test#*\?})
datenow=$(date +%s)
test=$(echo $datenow - $test | bc)
test=$(echo $test / 3600 | bc)
echo $test hours
