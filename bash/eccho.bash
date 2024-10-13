#!/bin/bash

#Scrivere uno script “eccho” che prende un argomento e lo stampa due volte

arg=$*; 

if [ -z "$*" ]
then
	echo "Inserire argomento.";
	read arg;
fi

echo $arg $arg;
