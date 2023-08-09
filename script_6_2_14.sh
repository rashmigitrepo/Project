#6.2.14
#!/bin/bash 
awk -F: '($1!~/(halt|sync|shutdown|nfsnobody|xman)/ && $7!~/^(\/usr)?\/sbin\/nologin(\/)?$/ && $7!~/(\/usr)?\/bin\/false(\/)?$/) { print $6 }' /etc/passwd | while read -r dir; do 
  if [ -d "$dir" ]; then 
    file="$dir/.forward" 
    if [ ! -h "$file" ] && [ -f "$file" ]; then 
      rm -r "$file" 
    fi 
  fi
done
