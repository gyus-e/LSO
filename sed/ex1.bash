#!/bin/bash

#Usare grep per selezionare tutte le linee che contengono la parola “when” oppure “When”
#Usare sed per selezionare tutte le linee che contengono la parola “when” oppure “When”

#grep -i "when" when.txt;
grep "[Ww]hen" when.txt;
egrep "(w|W)hen" when.txt;

echo "";

#sed -n -e "/when/p" -e "/When/p" when.txt;
sed -n -e "/[Ww]hen/p" when.txt;
