#!/bin/bash

a=$1;

if [ -z $a ]
then 
	echo "Digita una vocale";
	read a;
fi;

sed -e "s/[aeiou]/$a/g" Garibaldi.txt