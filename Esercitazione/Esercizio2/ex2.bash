#!/bin/bash

dir=$1;

if [ ! -d "$dir" ]
then 
    echo "specified directory does not exist"; 
    exit 1;
fi

groupNames=$(ls -l $dir | awk ' {print $4} ');

for groupName in $groupNames
do  
    if [ ! -d "output/$groupName" ]
    then
        mkdir output/$groupName
    fi

    groupUsers=$(ls -l $dir | awk -v groupName=$groupName '$4==groupName {print $3}');
    for userName in $groupUsers
    do 
        if [ ! -d "output/$groupName/$userName" ]
        then
            mkdir output/$groupName/$userName
        fi

        fileName=$(ls -l $dir | awk -v userName=$userName '$3==userName {print $9}');

        cp "$1/$fileName" "output/$groupName/$userName/$fileName"; #le variabili prendono caratteri speciali!
    done
done