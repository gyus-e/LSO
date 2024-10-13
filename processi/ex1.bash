#!/bin/bash

#Stampare il seguente stato interno del processo bash più recente.
#-PID del processo (pid)
#-Dimensione della memoria residente (rss)
#-Wait channel (wchan)
#-Tempo di CPU utilizzato (cputime)
#-Stato del processo (s oppure state)
#-Nome del comando (comm)

ps -o pid,rss,wchan,cputime,state,comm --sort etime -u $USER | head -2
