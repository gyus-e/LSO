#!/bin/bash

#Elencare le directory il cui nome inizia per maiuscola

#ls -d */ | grep "^[[:upper:]]"

ls -l | grep "^d" |  grep "\<[[:upper:]][[:alnum:]]*$"
