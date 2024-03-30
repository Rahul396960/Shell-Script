#!/bin/bash

result=""

 # Password for authentication
    password="c0l0!r@g3"
    password1="l0c@l!r@g3"


sshcopied=()
sshnotcopied=()

function ssh_copy {

    # Your local SSH key file
    # ssh_key_path="$HOME/.ssh/id_rsa.pub"

    local ipaddr="$1"
    local pass="$2"
       # Use ssh-keyscan to automatically accept the host key
        ssh-keyscan -H "$ipaddr" >> "$HOME/.ssh/known_hosts"

        # Copy the SSH key using sshpass
        sshpass -p "$pass" ssh-copy-id "root@$ipaddr"

        if [[ "$?" -eq 0 ]]; then
            echo "SSH key successfully copied to $line."
            sshcopied+=("$ipaddr")
        else
            echo "Failed to copy SSH key to $line. Check if SSH is set up correctly or try using SSH keys for more secure authentication."
            sshnotcopied+=("$ipaddr")
        fi
      
}

# Function to check if the IP address falls within the valid ranges
function is_valid_ip {

    local ip="$1"
    if [[ "$ip" == "172.16.200"* || "$ip" == "192.168.151."* || "$ip" == "192.168.155."* || "$ip" == "192.168.65."* ]]; then #  =~ operator is used for pattern matching. The pattern ^(10\.10\.10\.|10\.5\.5\.|10\.1\.1\.|10\.10\.1\.) checks if the IP address starts with one of the specified valid ranges. The ^ asserts the start of the string, and each range is separated by the | (logical OR) operator. 
            echo "$ip is in range"
            return 0  # IP is within a valid range
        elif [[ "$ip" == "172.16.100."* ]]; then
            echo "$ip is in range"
            return 2    # IP is within a valid range
        else
            return 1  # IP is not within a valid range
        fi
}

# Loop through each server and copy the SSH key
while IFS= read -r line; do
    # Resolve the IP address of the server

    # Check if the IP address is within a valid range
    is_valid_ip "$line"
    result=$?

    if [ "$result" -eq 0 ]; then
            echo "Copying SSH key to $line..."
            ssh_copy "$line" "$password"
    elif [ "$result" -eq 2 ]; then
            echo "Copying SSH key to $line..."
            ssh_copy "$line" "$password1"
    else
        echo "Skipping $line. IP address $line is not within a valid range."
    fi

    echo "----------------------------------------------------------------------"
done < "reachable_ip_new.txt"

# Print ssh copied IPs
echo "ssh copied IPs:"
printf '%s\n' "${sshcopied[@]}"
echo "======================="

# Print ssh not copied IPs
echo "ssh not copied IPs:"
printf '%s\n' "${sshnotcopied[@]}"
echo "------------------"