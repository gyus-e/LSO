#!/bin/awk -f

#Data una lista di stringhe separate dal carattere ":",
#sostituire il separatore tra la prima e la seconda stringa con il carattere speciale "-"

BEGIN {
    FS=":";
    ORS="-";
}

{
    for (i=1;i<=NF;i++) {
        if (i > 1) {
            ORS=":";
        }
    
        if (i == NF) {
            ORS="\n";
        }

        print $i;
    }
}