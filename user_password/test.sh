#!/bin/bash -x

my_array=("$(cat freeipa_user_email_details.csv)")

# Convert the array to JSON
json_array=$(printf "%s\n" "${my_array[@]}" | jq -R . | jq -s .)

# Call the Python script and pass the JSON array as an argument
python3 user_manage.py "$json_array"

# first() {
#     echo "this is first"
# }

# second(){
#     echo "this is second"
# }

# third() {
#     echo "this is third"
# }

# arr=(first second third)

# if [[ $1 == "-a" ]]; then
#     ${arr[0]}
# elif [[ $1 == "-b" ]]; then
#     ${arr[1]}
# elif [[ $1 == "-c" ]]; then
#     ${arr[2]}
# fi

# declare -A my_dict
#     my_dict["key1 first"]=''
#     my_dict["key2 second"]=''
#     my_dict["key3 third"]=''

#     for key in "${!my_dict[@]}"; do
#         i=0
#         while [ -z "${my_dict[$key]}" ]; do
#             echo "$key"
#             read -rp ":" "my_dict[$key]"
#             ((i += 1))
#             if [[ $i -eq 5 ]]; then
#                 echo "field cannot be empty"
#                 exit 1
#             fi
#         done
#     done

# echo "All values:"
# for value in "${my_dict[@]}"; do
#     echo "$value"
# done
