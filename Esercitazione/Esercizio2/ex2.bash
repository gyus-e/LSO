#!/bin/bash

true="true";

checkDirectoryExists () {
    if [[ -d "$1" ]]
    then 
        echo $true; 
    fi
}

makeDirectory () {
    dirName=$1;
    if [[ $(checkDirectoryExists "$dirName") != $true ]]
    then
        mkdir $dirName;
    fi
}

countDirectoryEntries () {
    dir=$1;
    numberOfEntries=$(ls "$dir" | grep -c ".*");
    echo $numberOfEntries;
}

checkDirectoryIsEmpty () {
    dir=$1;
    numberOfEntries=$(countDirectoryEntries $dir);
    if [[ $numberOfEntries -eq 0 ]]
    then 
        echo true;
    fi
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


removeDirectoryIfEmpty () {
    dir=$1;
    if [[ $(checkDirectoryIsEmpty "$1") == "$true" ]]
    then 
        removeDirectory "$dir";
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

copyFilesOfUserInGroupFromDirectory () {
    userName=$1;
    groupName=$2;
    dir=$3;

    fileNames=$(getFilesOfUserInGroupFromDirectory $userName $groupName $dir);
    for fileName in $fileNames
    do
        copyFileFromTo "$dir/$fileName" "output/$groupName/$userName/$fileName";
    done
}

organizeGroupFromDirectory () {
    groupName=$1;
    dir=$2;

    userNames=$(getUsersInGroupFromDirectory $groupName $dir);
    for userName in $userNames
    do
        makeDirectory "output/$groupName/$userName";
        copyFilesOfUserInGroupFromDirectory $userName $groupName $dir;
    done
}

organizeDirectoryByGroup () {
    dir=$1;

    groupNames=$(getGroupsFromDirectory $dir);
    for groupName in $groupNames
    do
        makeDirectory "output/$groupName";
        organizeGroupFromDirectory $groupName $dir;
    done
}

selectiveRemoveFilesOfUserInGroupFromDirectory () {
    userName=$1;
    groupName=$2;
    dir=$3;

    fileNames=$(getFilesOfUserInGroupFromDirectory $userName $groupName $dir);
    for fileName in $fileNames 
    do
        echo "Delete $groupName/$userName/$fileName? [Y/N]";
        read fileIsToBeDeleted;
        if [[ $fileIsToBeDeleted == "Y" ]] || [[ $fileIsToBeDeleted == "y" ]]
        then
            removeFile "output/$groupName/$userName/$fileName";
        fi
    done
}

selectiveRemoveFilesInGroupFromDirectory () {
    groupName=$1;
    dir=$2;
    
    userNames=$(getUsersInGroupFromDirectory $groupName $dir);
    for userName in $userNames 
    do
        selectiveRemoveFilesOfUserInGroupFromDirectory $userName $groupName $dir;
        removeDirectoryIfEmpty "output/$groupName/$userName";
    done
}

selectiveRemoveFilesFromOrganizedDirectory () {
    dir=$1;

    groupNames=$(getGroupsFromDirectory $dir);
    for groupName in $groupNames 
    do 
        selectiveRemoveFilesInGroupFromDirectory $groupName $dir;
        removeDirectoryIfEmpty "output/$groupName";
    done
}

main () {
    dir=$1
    if [[ $(checkDirectoryExists "$dir") == $true ]];
    then
        organizeDirectoryByGroup $dir;
        selectiveRemoveFilesFromOrganizedDirectory $dir;
    else 
        echo "specified directory does not exist";
        exit 1;
    fi
}

main $@;