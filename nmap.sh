#!/bin/bash

for ip in $(seq 2 50)
do
	ipAddr="10.0.5.$ip"
	ping -c1 $ipAddr &> /dev/null
	success=$?
	if [[ $success -eq 0 ]]; then
		echo $ipAddr
	fi
done > sweep.txt
