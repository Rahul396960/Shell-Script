#!/bin/bash

installed=()
notinstalled=()
alinstalled=()
unable_locate=()
unable_mount=()

function locate_install {
    local ip="$1"
    local pkg="$2"
    ssh_output=$(ssh -n "$ip" 'os=$(cat /etc/os-release | grep -i VERSION_ID | cut -d"=" -f2 | tr -d "\""); \
        locate "rhel-server-$os-x86_64-dvd.iso"' | head -n 1)
    if [[ $? -eq 0 ]]; then
        ssh "$ip" "mount $ssh_output /mnt"

        if [[ $? -eq 0 ]]; then
           ssh "$ip" yum install -y "$pkg"
                
            if [[ $? -eq 0 ]]; then
                installed+=("$ip")
            else
                notinstalled+=("$ip")
            fi
        else
            unable_mount+=("$ip")
        fi
    else
        unable_locate+=("$ip")
    fi

}

for server in $( #inputing values
    cat pkg.txt
); do

    echo "checking for $server"

    if [[ $(ssh "$server" yum list installed | grep -i "$1") ]]; then
        echo "already installed"
        alinstalled+=("$server")
        continue
    else
        ssh_output=$(ssh "$server" "df -hT | grep -i /mnt")

        if [[ $? -eq 0 ]]; then #check if last statement command ran properly or not
            ssh "$server" yum install -y "$1"
             if [[ $? -eq 0 ]]; then
                installed+=("$server")
            else
                notinstalled+=("$server")
            fi
        else
            locate_install "$server" "$1"
        fi
    fi
    echo "------------------"
done

echo "$1 package installed:"
# echo "/mnt used"
printf '%s\n' "${installed[@]}" #print the value of path has found for the iso

echo "======================="

echo "$1 package not installed:"
# echo "/mnt not used "
printf '%s\n' "${notinstalled[@]}" #print the value of path has not found for the iso

echo "======================="

echo "$1 Already installed:"
printf '%s\n' "${alinstalled[@]}"

echo "======================="

echo "unable to locate:"
printf '%s\n' "${unable_locate[@]}"

echo "======================="

echo "unable to mount:"
printf '%s\n' "${unable_mount[@]}"
