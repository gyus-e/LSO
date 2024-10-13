#!/bin/bash

#Scrivere a video i numeri da 0 a N, con N passato allo script da riga di comando.

n=$1;

if [ -z $1 ]
then
	echo "Please insert a positive integer.";
	read n;
fi;

let i=0;

while [ $i -le $n ]
do
	echo $((i++));
done;

