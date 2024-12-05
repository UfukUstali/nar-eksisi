#!/bin/bash

# Check the number of arguments
if [ $# -eq 1 ]; then
    # If there is exactly 1 argument, read the file and pass it to the script recursively
    cat "$1" | "$0"
    exit 0
elif [ $# -gt 1 ]; then
    # If there is more than 1 argument, print an error and exit
    echo "Error: Only one argument (a file) is allowed."
    exit 1
fi

# If no arguments are provided, continue with the loop
while IFS=' ' read -r username passwd; do
    # Ensure both username and password are provided
    if [ -n "$username" ] && [ -n "$passwd" ]; then
        # Use the password in the docker exec command to create the user account
        echo "$passwd" | docker exec -i dendrite /usr/bin/create-account --config /etc/dendrite/dendrite.yaml -username "$username" -passwordstdin
        echo "User '$username' created successfully."
    else
        echo "Invalid input for user creation: '$username' and/or '$passwd' missing."
    fi
done
