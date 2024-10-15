BEGIN {
    FS=":";
    tot=0;
    subtot=0;
} 
{
    subtot=($1*$2); 
    tot+=subtot; 
    print subtot
} 
END {
    print "tot = " tot;
} 

#   to run:
#   awk -f cliente.awk cliente.txt