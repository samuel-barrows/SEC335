#!/bin/bash

#make sure that all vars are set
if [ ! -n "$1" ]; then
  echo "Usage: bash portscan2.sh HOSTLIST PORTLIST SPEED"
  exit
elif [ ! -n "$2" ]; then
  echo "Usage: bash portscan2.sh HOSTLIST PORTLIST SPEED"
  exit
fi
#speed will be an optional var. we will check if it is set here
if [ ! -n "$3" ]; then
  speed=0.1
else
  speed=$3
fi

host=$1
port=$2

fileext=$(echo $host | cut -d '.' -f 2)
lastoct=$(echo $host | cut -d '.' -f 4)

if [ $fileext = "txt" ]; then
    echo "FORMAT: host,port"
    while read -r host; do
      while read -r port; do
        timeout $speed bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null &&
        echo "FOUND: $host,$port"
      done < $2
    done < $1
elif [ -z $lastoct ]; then
    echo "scanning range..."
    for addr in $(seq -f "$host.%g" 254); do
        timeout $speed bash -c "echo >/dev/tcp/$addr/$port" 2>/dev/null &&
	    echo "FOUND: $addr,$port"
    done

fi

#if [ -z $lastoct ]; then
#    echo "scanning range..."
#    for addr in $(seq -f "$host.%g" 254); do
#        timeout $speed bash -c "echo >/dev/tcp/$addr/$port" 2>/dev/null &&
#	    echo "FOUND: $addr,$port"
#    done
#else
#    echo "FORMAT: host,port"
#    while read -r host; do
#      while read -r port; do
#        timeout $speed bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null &&
#        echo "FOUND: $host,$port"
#      done < $2
#    done < $1
#fi


