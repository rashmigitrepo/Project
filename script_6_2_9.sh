#!/bin/bash 
awk -F: '($1!~/(halt|sync|shutdown|nfsnobody|xman)/ && $7!~/^(\/usr)?\/sbin\/nologin(\/)?$/ && $7!~/(\/usr)?\/bin\/false(\/)?$/) { print $1 " " $6 }' /etc/passwd | while read -r user dir; do 
  if [ ! -d "$dir" ]; then 
    echo "User: \"$user\" home directory: \"$dir\" does not exist, creating home directory"
    mkdir "$dir" 
    chmod g-w,o-wrx "$dir" 
    chown "$user" "$dir" 
  fi 
done
