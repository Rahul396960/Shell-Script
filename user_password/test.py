import csv

data = []
password = []

with open('/home/irage/scripts/Script_irage/irage/user_password/qi_wifi_user_passwords.csv', 'r') as csvfile:
    # Read all lines into a list
    lines = csvfile.readlines()

    # Loop through the last two lines
    for line in lines[-2:]:
        # Split the line after removing whitespace from each line
        splitted = line.strip().split(',')

        # Extract data and sample values
        data.append(splitted[0])
        password.append(splitted[1])

# Print the extracted data
for k in range(len(data)):
    print(f"data:{data[k]} sample:{password[k]}")
