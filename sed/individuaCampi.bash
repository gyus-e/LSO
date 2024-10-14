#!/bin/bash

sed -E -e "s/(.*) (.*) (.*)/nome:\1, cognome:\2, citta:\3/" individuaCampi.txt
