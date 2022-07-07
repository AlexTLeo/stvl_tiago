#!/bin/bash

# Calculates average CPU usage since this script starts up until it dies
COUNTER=0
CPUAVG=0
TEMP=0
trap ctrl_c INT

function ctrl_c() {
  echo 
  echo $CPUAVG
  echo
  echo $COUNTER
  echo
  result=$(perl -e "print $CPUAVG/$COUNTER")
  echo $result
  exit 0
}

while true
do
  TEMP=$(top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}')
  CPUAVG=$(awk "BEGIN{ print $CPUAVG + $TEMP }")
  COUNTER=$(awk "BEGIN{ print $COUNTER + 1 }")
  sleep 1
done
