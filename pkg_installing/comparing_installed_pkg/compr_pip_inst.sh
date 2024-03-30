#!/bin/bash

Installed=()
Not_Installed=()
pyths=(python python2 python2.7 python3 python3.6)
pkgs=( pip pip2 pip2.7 pip3 pip3.6)
server='root@192.168.151.139'
server1='root@192.168.151.13'

# for pyth in "${pyths[@]}";do
# # Run the Python script and capture its output
# echo "upgrading for $pyth"
# ssh "$server" "$pyth" install "$line" || printf '%s' \
# "Installation failed in $pkg  of $line"

# done 

for ((i=0;i<"${#pkgs[@]}";i++));do
# Run the Python script and capture its output
echo "for ${pyths[i]} with ${pkgs[i]}"

ssh "$server1" "${pkgs[i]}" install --upgrade pip

for line in $(python3 comp_pip_src.py "$server" "$server1" "${pkgs[i]}")
do
echo -e "\033[0;32m for ${pkgs[i]} \033[0m"
    echo -e "\033[0;32m installing $line \033[0m"
    # Use each line of the output in your shell script
    # echo "$line"
    ssh -n $server1 "${pkgs[i]} install $line" 

    if [[ $? -eq 0 ]]; then
        Installed+=("${pkgs[i]} => $line")
    else
    echo -e "\033[1;31m not_installed \033[0m" 
        Not_Installed+=("${pkgs[i]} => $line")
    fi

echo "--------------------------------------------"
done
echo "======================================"
done 

echo "installed"
printf '%s\n' "${Installed[@]}"

echo "======================================"

echo "not installed"
printf '%s\n' "${Not_Installed[@]}"

