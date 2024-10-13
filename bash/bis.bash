#!/bin/bash

#Scrivere uno script “bis” che prende un comando come argomento e lo esegue due volte

if [ -z "$*" ]
then
	echo "Inserire un comando come argomento.";
	exit 1;
fi;

$*;

if [ "$?" -ne 0 ]
then 
	echo "Comando inserito non valido."
	exit 1;
fi;

echo "";

$*
