#!/bin/bash

already_installed=()
not_installed=()

for k in $(cat solar.txt); do

#	scp -r $file root@"$k":~
	# ssh root@"$k" "yum list installed | grep -i sfutil" &> /dev/null
        ssh root@"$k" "rpm -q sfutils" &> /dev/null
        if [ $? -eq 0 ]; then
                    #echo "RPM file installed successfully on $k"
                    # echo "already installed $k"
		    already_installed+=("$k")
                else
                   # echo "Error copying RPM file to $str"
                    #install_issues+=("$k")
		     not_installed+=("$k")
                fi
done      

echo "======================="
echo "Already Installed:"
printf '%s\n' "${already_installed[@]}"
echo "------------------"

echo "======================="
echo "not Installed:"
printf '%s\n' "${not_installed[@]}"
echo "------------------"