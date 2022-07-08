#!/bin/bash

# Calculates average CPU usage since this script starts up until it dies
rm cpu_avg.txt
touch cpu_avg.txt

while true
do
  top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}' >> cpu_avg.txt
  sleep 1
done
