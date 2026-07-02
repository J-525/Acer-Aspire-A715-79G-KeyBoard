#!/bin/bash

LEVEL=$1
HEX=$(printf '%02x' "$LEVEL")

printf '\xCA' | sudo dd of=/sys/kernel/debug/ec/ec0/io bs=1 seek=$((0xF8)) conv=notrunc status=none
printf '\x06' | sudo dd of=/sys/kernel/debug/ec/ec0/io bs=1 seek=$((0xF9)) conv=notrunc status=none
printf "\\x$HEX" | sudo dd of=/sys/kernel/debug/ec/ec0/io bs=1 seek=$((0xFA)) conv=notrunc status=none

printf '\xCA' | sudo dd of=/sys/kernel/debug/ec/ec0/io bs=1 seek=$((0xF8)) conv=notrunc status=none
printf '\x06' | sudo dd of=/sys/kernel/debug/ec/ec0/io bs=1 seek=$((0xF9)) conv=notrunc status=none
printf "\\x$HEX" | sudo dd of=/sys/kernel/debug/ec/ec0/io bs=1 seek=$((0xFA)) conv=notrunc status=none
