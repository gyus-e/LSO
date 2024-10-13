#!/bin/bash

#Individuare tutti i processi bloccati (stato S) ed in esecuzione (stato R) sulla  macchina

ps -e -o pid,comm,s | egrep "(S|R)$"
