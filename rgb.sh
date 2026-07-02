#!/bin/bash

ZONE=3
R=$1
G=$2
B=$3

cd /sys/kernel/debug/ec/ec0 || exit 1

printf "\\x$(printf '%02x' $ZONE)" | sudo dd of=io bs=1 seek=$((0xF9)) conv=notrunc status=none
printf "\\x$(printf '%02x' $B)"    | sudo dd of=io bs=1 seek=$((0xFA)) conv=notrunc status=none
printf "\\x$(printf '%02x' $G)"    | sudo dd of=io bs=1 seek=$((0xFB)) conv=notrunc status=none
printf "\\x$(printf '%02x' $R)"    | sudo dd of=io bs=1 seek=$((0xFC)) conv=notrunc status=none
printf '\x00'                      | sudo dd of=io bs=1 seek=$((0xFD)) conv=notrunc status=none

printf '\xCA'                      | sudo dd of=io bs=1 seek=$((0xF8)) conv=notrunc status=none
