import subprocess
import csv


output=subprocess.check_output(["bash","source.sh"])

lines = output.decode().split("\n")
lines = [line for line in lines if line]

# row = 'Username,New_username,Password,Firstname,Lastname'
row = 'username,password'

with open('check.csv', 'w', newline='') as csvfile:
    csvwriter = csv.writer(csvfile)
    csvwriter.writerow(row.split(','))  # Write header

    for line in lines:
        csvwriter.writerow(line.split(',')) #write data
        print(line)
                