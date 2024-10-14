#!/bin/bash

#(c) Stampare la dimensione totale occupata dai files regolari appartenenti al gruppo staff

ls -l | awk ' $4=="staff" { print $5 }' | awk ' { s+=$1 } END {print s} '
