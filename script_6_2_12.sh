#6.2.12
#!/bin/bash 
awk -F: '($1!~/(halt|sync|shutdown|nfsnobody|xman)/ && $7!~/^(\/usr)?\/sbin\/nologin(\/)?$/ && $7!~/(\/usr)?\/bin\/false(\/)?$/) { print $6 }' /etc/passwd | while read -r dir; do 
  if [ -d "$dir" ]; then 
    for file in "$dir"/.*; do 
      if [ ! -h "$file" ] && [ -f "$file" ]; then 
        fileperm=$(stat -L -c "%A" "$file") 
        if [ "$(echo "$fileperm" | cut -c6)" != "-" ] || [ "$(echo "$fileperm" | cut -c9)" != "-" ]; then 
           echo "Default Permission for \"$dir/$file\" is: \"$fileperm\". But as per policy setting permission to \"rw-r--r--\"."
          chmod go-w "$file" 
        fi 
      fi 
    done 
  fi 
done
