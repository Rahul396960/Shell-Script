import subprocess
import sys

# Define the command to be executed
server1 = sys.argv[1]
server2 = sys.argv[2]
ver = sys.argv[3]

command = f"result='';for i in $(ssh -n {server1} {ver} list | awk '{{print $1}}' | sed '1d;2d'); do result=$result' '$i; done; echo $result"

# Run the command and capture the output
try:
    output = subprocess.check_output(command, shell=True, text=True)
    # print(output)
except subprocess.CalledProcessError as e:
    print(f"Error: {e}")

# print()

command1 = f"result='';for i in $(ssh -n {server2} {ver} list | awk '{{print $1}}' | sed '1d;2d'); do result=$result' '$i; done; echo $result"

# Run the command and capture the output
try:
    output1 = subprocess.check_output(command1, shell=True, text=True)
    # print(output1)
except subprocess.CalledProcessError as e:
    print(f"Error: {e}")

# Function to split text into an array of words
def text_to_array(text):
    # Use the split() method to split the text into words
    words = text.split()
    return words

# Convert the texts to arrays of words
array1 = text_to_array(output)
array2 = text_to_array(output1)

# Find elements in array2 that don't match with array1
not_matched_in_array2 = [elem for elem in array1 if elem not in array2]

# # Find elements in array1 that don't match with array2
# not_matched_in_array1 = [elem for elem in array1 if elem not in array2]

for elem in not_matched_in_array2:
    print(elem)

# for elem in array2:
#     print(elem)




