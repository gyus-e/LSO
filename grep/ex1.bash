#!/bin/bash

#Elencare i file con permesso di esecuzione per il proprietario

ls -l | grep "^-..x\+"
