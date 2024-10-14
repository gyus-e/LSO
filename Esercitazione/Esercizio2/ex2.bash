#!/bin/bash

dir=$1

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

        fileNames=$(ls -l $dir | awk -v userName=$userName -v groupName=$groupName '$3==userName && $4==groupName {print $9}');
        for fileName in $fileNames
        do
            #si usa grep per prendere solo i caratteri stampabili eliminando i caratteri speciali
            oldPath=$(echo "$dir/$fileName" | grep [[:print:]]); 
            newPath=$(echo "output/$groupName/$userName/$fileName" | grep [[:print:]]);

            cp "$oldPath" "$newPath"; 
        done
    done
done
