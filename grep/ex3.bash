#!/bin/bash

#Elencare i file con permesso di esecuzione oppure di scrittura per il gruppo di appartenenza

#ls -l | egrep "^-....(w.|.x)"

ls -l | grep "^-....\(w.\|.x\)"
