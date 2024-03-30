import subprocess
import csv

data = []
new_user=[]
password = []
firstname = []
lastname = []

bash_script_path = "group.sh"  # Define the path to the Bash script

output = subprocess.check_output(["bash", bash_script_path])    # Execute the Bash script and capture its output

lines = output.decode().split("\n") # Convert the byte output to string and split it into lines

lines = [line for line in lines if line]    # Remove any empty lines

# Hdr_row=['Username', 'Password', 'Firstname', 'Lastname', "Email id"]

with open('irage_vpn_user_passwords.csv', 'a', newline='') as csvfile:     # Write output to CSV file

    csvwriter = csv.writer(csvfile)
    # csvwriter.writerow(Hdr_row)  # Write header

    for line in lines:
        csvwriter.writerow(line.strip().split(',')) #write data
        print(line)
