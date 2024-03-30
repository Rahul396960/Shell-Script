#!/bin/bash

# Function to generate a random password
generate_password() {
    local length=4
    local lower='abcdefghijklmnopqrstuvwxyz'
    local upper='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    local digits='0123456789'
    local special='!@#$%^&*()-=_+[]{}|;:.<>?'

    # Concatenate all possible characters
    local all_chars="$lower$upper$digits$special"

    # Initialize password with one character from each category
    password="${lower:RANDOM%${#lower}:1}${upper:RANDOM%${#upper}:1}${digits:RANDOM%${#digits}:1}${special:RANDOM%${#special}:1}"

    # Append random characters to meet desired length
    local remaining_length=$((length - 4))
    for ((i=0; i<remaining_length; i++)); do
        password+=${all_chars:RANDOM%${#all_chars}:1}
    done

    # Shuffle password characters to make it more random
    password=$(shuf -n${length} -e "$(echo ${password} | fold -w1)" | tr -d '\n')

    # Check if the password meets the criteria
    if [[ "$password" =~ [[:lower:]] && "$password" =~ [[:upper:]] && "$password" =~ [[:digit:]] && "$password" =~ [[:punct:]] ]]; then
        echo "$password"
    else
        generate_password
    fi
}

create_user() {
        # adding user with password
        local user=$1
        local pass=$2
        local first=$3
        local last=$4
        local eml=$5
    ipa user-add "$user" --first="$first" --last="$last" --password --email="$eml" >/dev/null 2>&1 <<  EOF
        $pass
EOF

    echo "$user,$pass,$first,$last,$eml"
}

change_password() {
        #changing password
        local user=$1
        local pass=$2
    ipa user-mod "$user" --password >/dev/null 2>&1 <<  EOF
        $pass
EOF

    echo "$user","$pass"
}

create_existing_user() {
    local user=$1
    local pass=$2
    local first
    local last
    first=$(ipa user-find "$user" | grep -iE "first name:" | cut -d : -f 2 | tr -d ' ')
    last=$(ipa user-find "$user" | grep -iE "last name:" | cut -d : -f 2 | tr -d ' ')

    new_user="$user""_vpn"
   # new_user=$(create_user "$user" "$pass" "$first" "$last")

    echo "$user" "$new_user" "$pass" "$first" "$last"
    #echo "$user,$new_user"
}

delete_user() {
    local user=$1
    verify=$(ipa user-del "$user" | grep -i deleted | cut -d \" -f 2)
    if [[ "$verify" = "$user" ]]; then
        return 0
    else
        return 1
    fi
}
# qi_wifi_users=(puja.n ashutosh.t akhilesh.s karina.a divyang.t akil.t lalan.w abhishek.soni rasid.p anurag.s afrin.s rohan.m prerna.n abhishek.sh sandeep.b dhrumin.v bernice.m prodipta.g sanika.b sana.p)

# qi_wifi_users=(jumana.l anupriya nitesh)

# qi_vpn_users=(dhruvmin.v madhusai.r pranav.a kishan.m sonam.d garvjeet.s sachin.p nisha.s vedant.m akhilesh.s akil.v slomy.v jay.p aushutosh.d chainika.t ishan.s prodipta.g viraj.b rekhit.p sainika.p shaival.p premanand.m markand.s paresh.r sarvesh.p subhash.k deepa.m laxmi.r rahul.n siddhesh.k rohit.s dhiraj.y ajit.c swati.g puja.n rohan.m jumana.l vivek.m anupriya.g afrin.s)

qi_users=(dakshay.m ramdas jfnmgh fyjgdjd)

irage_vpn=(pratik.p prinkesh.s deepak.l anil.y shashant.r ujjwal.p bhoomika.m arun.p harsh.s sunny.j adarsh.s)
err=()
# Generate passwords
passwords=()
# for user in "${irage_vpn[@]}"; do
for usd in $(cat freeipa_user_email_details.csv); do

    user=$(echo "$usd" | cut -d , -f 1)
    first=$(echo "$usd" | cut -d , -f 2)
    last=$(echo "$usd" | cut -d , -f 3)
    email=$(echo "$usd" | cut -d , -f 4)

    grp=$(ipa user-show $user | grep -i "Member of groups:" | cut -d : -f 2 | tr -d ' ')
    ar=();ng=()
    IFS=',' read -ra ar <<< $grp
    for i in "${ar[@]}";do 
        if [[ $i = *"vpn"* ]];then 
            ng+=("$i")
        fi
    done
    # Generate password
    password=$(generate_password)
    # Check if the password already exists
    passwords+=("$password")
    for existing_password in "${passwords[@]}"; do
        if [[ "$existing_password" == "$password" ]]; then
            password=$(generate_password)
            break
        fi
    done

    nuser="$user""_vpn"
    pass="$user$password"

# change_password "$user" "$pass"
    create_user "$nuser" "$pass" "$first" "$last" "$email"

    for ug in "${ng[@]}"; do
        ipa group-add-member "$ug" --users="$nuser"
    done

done
