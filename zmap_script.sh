#!/bin/bash

function filterResults(){
	if [ ! -d "Hit" ]
	then
		mkdir Hit
	fi
	
	for ((i=1; i<=3500; i++))
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
}

function folder(){
	if [[ "$IP" =~ "/" ]]
	then
	folder=$(echo $IP | tr "/" "-")
	mkdir $folder
	elif [ "$IP" != "${IP/ /}" ]
	then
	folder="ZMap_results"
	mkdir $folder
	else
	folder=$IP
	mkdir $folder
        fi
}

function ZMap(){
	zmap -p $i -f "saddr,daddr,sport,dport,classification,ttl,ipid" -o $folder/port_$i.csv $IP
}

function zmapPorts(){
	echo "Enter ports (etc. 80 110): "
	read ports;
	echo "Enter IP"
        read IP;
	folder

        for i in $ports
	do
	   ZMap
	done
	cd $folder
	filterResults
}

function zmapPortRange(){
	echo "From port (etc. 25): "
	read fromPort;
        echo "To port (etc. 50): "
	read toPort;
	echo "Enter IP: "
        read IP;
	folder

	for ((i=$fromPort; i<=$toPort; i++))
	do
          ZMap
	done
	cd $folder
	filterResults
}

function zmapKnownPorts(){
	echo "Enter IP"
        read IP;
	folder


        for i in 1 5 7 18 20 21 22 23 25 29 37 42 43 49 53 69 70 79 80 103 108 109 110 115 118 119 137 139 143 150 156 161 179 190 194 197 389 396 443 444 445 458 546 547 563 569 1080
	do
	   ZMap
	done
	cd $folder
	filterResults
}




echo "1 Specific port(s) etc. 80 110 " 
echo "2 Port range etc. 25..50"
echo "3 Well known ports"

read case;

case $case in 
	1) zmapPorts;;
	2) zmapPortRange;;
	3) zmapKnownPorts;;

esac
