#!/bin/bash

#(c) Stampare la dimensione totale occupata dai files regolari appartenenti al gruppo staff

ls -l | awk ' $4=="staff" { s+=$5 } END {print s} '
