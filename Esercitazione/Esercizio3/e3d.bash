#!/bin/bash

# Dato un file "fiori.txt" contenente ordini di acquisto per fiori nella forma:
# nome_persona nome_fiore quantitá costo
# stampare su un'unica riga per ogni nome_persona i nome_fiore dei fiori acquistati

file="fiori.txt";

getUserNames () {
    file=$1;
    awk '{print $1}' $file | sort -u;
}

getFlowersOfUserFromFile () {
    nomePersona=$1;
    file=$2;
    awk -v nomePersona=$nomePersona 'BEGIN {ORS=" "} $1==nomePersona {print $2}' $file;
}

nomiPersone=$(getUserNames $file);
for nomePersona in $nomiPersone
do
    listaFiori=$(getFlowersOfUserFromFile $nomePersona $file);
    echo "$nomePersona $listaFiori";
done