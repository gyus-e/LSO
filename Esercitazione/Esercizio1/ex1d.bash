#!/bin/bash

#(d) Elencare i nomi dei files modificati tra il 2006 e il 2008

ls -l --time-style="+%Y-%m-%d" | awk ' { print $6 " " $7 } ' | egrep "^(2006|2007|2008)";

