#5.5.1
#!/usr/bin/env bash 
for fn in system-auth password-auth; do 
  file="/etc/authselect/$(head -1 /etc/authselect/authselect.conf | grep 'custom/')/$fn"
    if ! grep -Pq -- '^\h*password\h+requisite\h+pam_pwquality.so(\h+[^#\n\r]+)?\h+.*enforce_for_r oot\b.*$' "$file"; then 
      sed -ri 's/^\s*(password\s+requisite\s+pam_pwquality.so\s+)(.*)$/\1\2 enforce_for_root/' "$file" 
    fi 
    if grep -Pq -- '^\h*password\h+requisite\h+pam_pwquality.so(\h+[^#\n\r]+)?\h+retry=([4- 9]|[1-9][0-9]+)\b.*$' "$file"; then 
      sed -ri '/pwquality/s/retry=\S+/retry=3/' "$file" 
    elif ! grep -Pq -- '^\h*password\h+requisite\h+pam_pwquality.so(\h+[^#\n\r]+)?\h+retry=\d+\b.*$' "$file"; then 
      sed -ri 's/^\s*(password\s+requisite\s+pam_pwquality.so\s+)(.*)$/\1\2 retry=3/' "$file" 
    fi 
done 
authselect apply-changes
