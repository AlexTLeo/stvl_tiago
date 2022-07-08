#!/bin/bash

# Calculates average CPU usage since this script starts up until it dies
while true
do
  top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}' >> cpu_avg.txt
  sleep 1
done
