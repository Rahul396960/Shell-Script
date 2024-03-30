#!/bin/bash

#extracting ips
#checking which server have solarflare cards
#installing package file on those server
#and then printing on which system package installation was successful and unsuccessful.

reachable_ips=()
unreachable_ips=()

cont_sol=()
non_sol=()

while IFS= read -r line; do
    # Skip blank lines and lines starting with #
    if [[ -n "$line" && "$line" != "#"* ]]; then
        str=$(echo "$line" | cut -d@ -f2 | cut -d"'" -f1)

        # Check if the IP is reachable using ping
        if ping -c 1 -W 1 "$str" &> /dev/null; then
#            echo "IP: $str is reachable"
            reachable_ips+=("$str")
        else
             echo "IP: $str is not reachable"
            unreachable_ips+=("$str")
        fi
    fi
done < "2.txt"

echo "------------------"

for i in "${reachable_ips[@]}"; do
   # echo IP: "$i"
     ssh_output=$(ssh root@"$i" "lspci | grep -i ethernet")
	     # echo "$ssh_output"
             echo "$ssh_output" | grep -qiE 'solarflare|solar'
              if [ $? -eq 0 ]; then
                # echo "Contains 'Solarflare' or 'solar':"
                 #echo "$ssh_output"
		  cont_sol+=("$i")
		  echo "$i" >> solar.txt
	      else
		 #echo "doesn't contains 'Solarflare' or 'solar':"
		 #echo "$ssh_output"
		  non_sol+=("$i")
	      fi
#    echo "------------------"
#    ssh root@"$i" "free -g"
done


    echo "------------------"

#to check is server reachable or not
# Print reachable IPs
#echo "Reachable IPs:"
#printf '%s\n' "${reachable_ips[@]}"
#echo "======================="

# Print unreachable IPs
#echo "Unreachable IPs:"
#printf '%s\n' "${unreachable_ips[@]}"
#echo "------------------"


# to check solarflare
#echo " IPs:"
#printf '%s\n' "${cont_sol[@]}"

#echo "======================="

#echo "IPs:"
#printf '%s\n' "${non_sol[@]}"

file=sfutils-7.3.4.1001-1.x86_64.rpm
install_issues=()
already_installed=()
not_installed=()

for k in "${cont_sol[@]}"; do

#	scp -r $file root@"$k":~
	ssh root@"$k" "rpm -ivh $file"
        if [ $? -eq 0 ]; then
                    #echo "RPM file installed successfully on $k"
                    echo "already installed $k"
		    already_installed+=("$k")
                else
                   # echo "Error copying RPM file to $str"
                    #install_issues+=("$k")
		     not_installed+=("$k")
                fi
	echo "------------------"
done      

echo "======================="
echo "Already Installed:"
printf '%s\n' "${already_installed[@]}"
echo "------------------"

echo "======================="
echo "not Installed:"
printf '%s\n' "${not_installed[@]}"
echo "------------------"
