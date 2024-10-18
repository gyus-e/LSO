#!/bin/bash

checkIfDirectoryExists () {
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

cleanPath () {
    path=$1;
    echo "$path" | grep [[:print:]];
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
                sorucePath=$(cleanPath "$dir/$fileName");
                targetPath=$(cleanPath "output/$groupName/$userName/$fileName");
                cp "$sorucePath" "$targetPath"; 
            done
        done
    done
}

part2 () {
    dir=$1;

    groupNames=$(getGroupsFromDirectory $dir);
    for groupName in $groupNames 
    do 
        howManyInGroupDirectory=$(countDirectoryEntries "output/$groupName");

        userNames=$(getUsersInGroupFromDirectory $groupName $dir);
        for userName in $userNames 
        do
            howManyInUserDirectory=$(countDirectoryEntries "output/$groupName/$userName");

            fileNames=$(getFilesOfUserInGroupFromDirectory $userName $groupName $dir);
            for fileName in $fileNames 
            do 
                echo "Delete $groupName/$userName/$fileName? [Y/N]";
                read fileIsToBeDeleted;
                if [ $fileIsToBeDeleted == "Y" ] || [ $fileIsToBeDeleted == "y" ]
                then
                    rm "$(cleanPath "output/$groupName/$userName/$fileName")";
                    ((howManyInUserDirectory--));
                fi

                if  [ $howManyInUserDirectory -eq 0 ]
                then 
                    rmdir "$(cleanPath "output/$groupName/$userName")";
                    ((howManyInGroupDirectory--));
                fi
            done
        done
            
        if [ $howManyInGroupDirectory -eq 0 ]
        then 
            rmdir "$(cleanPath "output/$groupName")";
        fi
    done
}

main () {
    dir=$1
    checkIfDirectoryExists "$dir";

    part1 $dir;
    part2 $dir;
}

main $@;