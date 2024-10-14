#!/bin/bash

#(b) Elencare i nomi dei files regolari appartenenti all’utente "utente1" oppure al gruppo "staff"

ls -l | egrep "^-" | awk '($3=="utente1" || $4=="staff") { print $9 }';

ls -l | awk '"^-" ($3=="utente1" || $4=="staff") { print $9 }';

ls -l | awk ' ($1=="^-.*") ($3=="utente1" || $4=="staff") { print $9 }';
