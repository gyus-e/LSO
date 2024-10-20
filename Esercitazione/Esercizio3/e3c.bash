#!/bin/bash

#Estrarre tutte le righe contenenti la stringa "LSO" e "lso" e la riga subito dopo.
#Stamparle a video.

fileExists () {
    if [ ! -f $1 ]
    then
        echo "file does not exist";
        exit 1;
    fi
}

fileName="stringhe.txt";
fileExists $fileName;

awk '/lso|LSO/ {print $0; getline $0; print $0}' $fileName; #getline sul man?
echo "";
sed -E -n -e "/(lso|LSO)/{p;n;p}" $fileName; #parentesi graffe?

