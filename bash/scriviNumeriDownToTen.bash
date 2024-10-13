#!/bin/bash

#scrivere a video numeri da N a 10

x=$1;

if [ -z $1 ]
then
	echo "Please insert a positive integer greater than 10";
	read x;
fi;

if [ $x -lt 10 ]
then
	echo "Number is not greater than 10";
	exit 1;
fi;

let i=$x;

until [ $i -lt 10 ]
do
	echo $((i--));
done;
