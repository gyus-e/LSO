#!/bin/awk -f

#Data una lista di stringhe separate dal carattere ":",
#sostituire la prima e la seconda stringa con il carattere speciale "-".
#"Valori di stringhe non possono essere vuote.

BEGIN {
    FS=":";
    OFS=":";
}
{
    
    if ($1=="" || $2=="") {
        print "error";
        exit 1;
    }
    $1="-";
    $2="-";
    print;
}