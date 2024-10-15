#!/bin/bash

awk -F":" ' 
BEGIN {
    tot=0;
    subtot=0;
}
{
    subtot=($1*$2); 
    tot+=subtot; 
    print subtot
} 
END {
    print "tot = " tot
} 
' cliente.txt;