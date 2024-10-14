#!/bin/bash

#Sostituire “Alessandra Rossi Napoli” con “Sig Alessandra-Rossi Da Napoli

sed -E -e  "s/(.*) (.*) (.*)/Sig \1-\2 Da \3/" AlessandraRossi.txt;
