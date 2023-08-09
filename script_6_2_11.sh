#6.2.11
#!/bin/bash 
awk -F: '($1!~/(halt|sync|shutdown|nfsnobody|xman)/ && $7!~/^(\/usr)?\/sbin\/nologin(\/)?$/ && $7!~/(\/usr)?\/bin\/false(\/)?$/) {print $6}' /etc/passwd | while read -r dir; do 
  if [ -d "$dir" ]; then 
    dirperm=$(stat -L -c "%A" "$dir") 
    if [ "$(echo "$dirperm" | cut -c6)" != "-" ] || [ "$(echo "$dirperm" | cut -c8)" != "-" ] || [ "$(echo "$dirperm" | cut -c9)" != "-" ] || [ "$(echo "$dirperm" | cut -c10)" != "-" ]; then 
      echo "Default Permission is: \"$dirperm\" for your home directory: \"$dir\". But as per policy setting permission to \"drwxr-x---\" which is \"750\" in numerical form."      
      chmod g-w,o-rwx "$dir" 
    fi 
  fi 
done
