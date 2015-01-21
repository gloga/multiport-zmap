#!/bin/bash

if [ ! -d "Hit" ]
then
	mkdir Hit
fi

for i in {1..3500}
do
	if [ -f "port_$i.csv" ]
	then
		br=$(wc -c < port_$i.csv)
		if [[ "$br" -gt "54" ]]
		then 
			cp port_$i.csv Hit
		fi
	fi		
done