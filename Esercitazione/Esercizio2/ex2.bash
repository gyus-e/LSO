#!/bin/bash

checkDirectoryExists () {
    if [ ! -d "$1" ]
    then 
        echo "specified directory does not exist"; 
        exit 1;
    fi
}

makeDirectory () {
    dirName=$1;
    if [ ! -d "$dirName" ]
    then
        mkdir $dirName;
    fi
}

countDirectoryEntries () {
    dir=$1;
    directoryEntries=$(ls "$dir" | grep -c ".*");
    echo $directoryEntries;
}

checkDirectoryIsEmpty () {
    dir=$1;
    directoryEntries=$(countDirectoryEntries $dir);
    if [ $directoryEntries -eq 0 ]
    then 
        echo true;
    fi
}

getGroupsFromDirectory () {
    dir=$1;

    groupNames=$(ls -l $dir | awk ' {print $4} ' | sort -u);
    echo $groupNames;
}

getUsersInGroupFromDirectory () {
    groupName=$1;
    dir=$2;

    userNames=$(ls -l $dir | awk -v groupName=$groupName '$4==groupName {print $3}' | sort -u);
    echo $userNames;
}

getFilesOfUserInGroupFromDirectory () {
    userName=$1;
    groupName=$2;
    dir=$3;

    fileNames=$(ls -l $dir | awk -v userName=$userName -v groupName=$groupName '$3==userName && $4==groupName {print $9}' | sort -u);
    echo $fileNames;
}

getPrintable () {
    echo "$@" | grep [[:print:]];
}

copyFileFromTo () {
    sorucePath=$(getPrintable "$1");
    targetPath=$(getPrintable "$2");
    cp "$sorucePath" "$targetPath"; 
}

removeFile () {
    filePath=$(getPrintable "$1");
    rm "$filePath";
}

removeDirectory () {
    directoryPath=$(getPrintable "$1");
    rmdir "$directoryPath";
}

part1 () {
    dir=$1;

    groupNames=$(getGroupsFromDirectory $dir);
    for groupName in $groupNames
    do
        makeDirectory "output/$groupName";

        userNames=$(getUsersInGroupFromDirectory $groupName $dir);
        for userName in $userNames
        do 
            makeDirectory "output/$groupName/$userName";
            
            fileNames=$(getFilesOfUserInGroupFromDirectory $userName $groupName $dir);
            for fileName in $fileNames
            do
                copyFileFromTo "$dir/$fileName" "output/$groupName/$userName/$fileName";
            done
        done
    done
}

part2 () {
    dir=$1;

    groupNames=$(getGroupsFromDirectory $dir);
    for groupName in $groupNames 
    do 
        userNames=$(getUsersInGroupFromDirectory $groupName $dir);
        for userName in $userNames 
        do
            fileNames=$(getFilesOfUserInGroupFromDirectory $userName $groupName $dir);
            for fileName in $fileNames 
            do
                echo "Delete $groupName/$userName/$fileName? [Y/N]";
                read fileIsToBeDeleted;
                if [ $fileIsToBeDeleted == "Y" ] || [ $fileIsToBeDeleted == "y" ]
                then
                    removeFile "output/$groupName/$userName/$fileName";
                fi
            done

            if  [ $(checkDirectoryIsEmpty "output/$groupName/$userName") == "true" ]
            then 
                removeDirectory "output/$groupName/$userName";
            fi
        done
            
        if [ $(checkDirectoryIsEmpty "output/$groupName") == "true" ]
        then 
            removeDirectory "output/$groupName";
        fi
    done
}

main () {
    dir=$1
    checkDirectoryExists "$dir";

    part1 $dir;
    part2 $dir;
}

main $@;