#!/bin/bash
yosys -p "synth_ice40 -top icebreaker_top -blif icebreaker_top.blif" ./icebreaker_top.v
arachne-pnr -d 5k icebreaker_top.blif -o ./icebreaker_top.asc -p ../constr/icebreaker_top.pcf -w icebreaker_top.asc.pcf
icepack icebreaker_top.asc icebreaker_top.bin
