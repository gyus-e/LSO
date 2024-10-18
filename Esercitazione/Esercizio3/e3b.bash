#!/bin/bash

echo "first:second:third" | awk -F":" '{print $2}'

#scrivere un programma equivalente usando sed

echo "first:second:third" | sed -E -e "s/:/\n/g" | sed -n "2p"
echo "first:second:third" | sed -E -e "s/(^.*):(.*):(.*$)/\2/"