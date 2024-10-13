#!/bin/bash

#Scrivere uno script “eccho” che prende un argomento e lo stampa due volte

if [ -z "$*" ]
then
	echo "Inserire argomento.";
	exit 1;
fi

echo $1 $1
