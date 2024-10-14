#!/bin/awk -f

#a sample awk program
#to run this script simply type "./hello.awk hello.txt"

/foo/ { print $1 }