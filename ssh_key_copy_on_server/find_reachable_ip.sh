#!/bin/bash

reachable_ips=()
unreachable_ips=()

rm -rf unreachable_ip_new.txt reachable_ip_new.txt

while IFS= read -r line; do
    # Skip blank lines and lines starting with #
    if [[ -n "$line" && "$line" != "#"* ]]; then
        str=$(echo "$line" | cut -d@ -f2 | cut -d"'" -f1)

        # Check if the IP is reachable using ping
        if ping -c 1 -W 2 "$str" &> /dev/null; then
            echo "IP: $str is reachable"
#            echo $str >> "reachable_ip_new.txt"
            reachable_ips+=("$str")
        else
            echo "IP: $str is not reachable"
#            echo $str >> "unreachable_ip_new.txt"
            unreachable_ips+=("$str")
        fi
    fi
done < "2.txt"

printf '%s\n' "${reachable_ips[@]}" > "reachable_ip_new.txt"
printf '%s\n' "${unreachable_ips[@]}" > "unreachable_ip_new.txt"
