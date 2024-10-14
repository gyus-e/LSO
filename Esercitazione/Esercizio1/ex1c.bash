#!/bin/bash

#(c) Stampare la dimensione totale occupata dai files regolari appartenenti al gruppo staff

ls -l | awk '{ print $5 " " $4 }' | grep "staff";
#incompleto, manca la somma
