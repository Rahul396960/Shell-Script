import csv
import json
import sys
import os
import re

# bash_script_path = "group.sh"  # Define the path to the Bash script

# output = subprocess.check_output(["bash", bash_script_path])    # Execute the Bash script and capture its output

# lines = output.decode().split("\n") # Convert the byte output to string and split it into lines

# lines = [line for line in lines if line]    # Remove any empty lines

# # Hdr_row=['Username', 'Password', 'Firstname', 'Lastname', "Email id"]

# Get the JSON array from the command-line arguments
def file_edit(array, filename, mode):
    with open(filename, mode, newline='') as csvfile:
        csvwriter = csv.writer(csvfile)
        for line in my_array:
            csvwriter.writerow(line)  # write data
            print(line)

json_array = sys.argv[1]
file = sys.argv[2]
option=sys.argv[3]
header = ['Username','Firstname', 'Lastname', 'Email id']

# Parse the JSON array into a Python list
my_array = json.loads(json_array)

if re.match('[a-d]', option):
    if os.path.exists(file) and os.stat(file).st_size > 0:  # Check if file exists and is not empty
        file_edit(my_array,file,'a')
    else:
        my_array.insert(0, header)  # Insert header at the beginning
        file_edit(my_array,file,'w')



