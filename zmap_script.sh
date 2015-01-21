#!/bin/bash

args=("$@")

ime=$(echo $@ | tr "/" "-")

mkdir $ime

cd $ime

for i in 7 20 21 22 23 25 43 58 70 80 88 101 107 108 109 110 115 118 143 156 220 443 444 445 465 546 547 631 636 843 873 901 902 903 904 953 973 991 1293 1433 1434 2049 3306

do

	sudo zmap -p $i -f "saddr,daddr,sport,dport,classification,ttl,ipid" -o port_$i.csv --summary  $@

done