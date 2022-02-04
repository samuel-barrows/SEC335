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
dnsserv=$2

lastoct=$(echo $host | cut -d '.' -f 4)

if [ -z $lastoct ]; then
    echo "scanning range..."
    for addr in $(seq -f "$host.%g" 254); do
	lookup=$(nslookup $addr $dnsserv 2> /dev/null)
	if [ $(echo $lookup | cut -d " " -f 3) != "server" ]; then
	    echo $lookup
	fi
    done

fi


