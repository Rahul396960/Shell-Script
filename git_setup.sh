#!/bin/bash

# Script to configure Git and set a remote origin

# Ask for user information
read -p "Enter your Git username: " username
read -p "Enter your Git email: " email

# Optional configurations
# git config --global init.defaultBranch main
# git config --global color.ui true

# Set a remote origin
read -p "Enter the URL for the remote origin (leave empty if not needed): " remote_url
read -p "Enter the local path to your Git repository (leave empty if already in the repo's path): " repo_path

# Set global configurations
git config --global user.name "$username"
git config --global user.email "$email"

if [[ -n $remote_url ]]; then
    if [[ -n $repo_path ]]; then
        # Navigate to the Git repository and set the remote origin
        cd "$repo_path" && git init && git remote add origin "$remote_url" && echo "Remote origin set to $remote_url in $repo_path"
    else
        # Set the remote origin in the current directory
        git remote add origin "$remote_url" && echo "Remote origin set to $remote_url in the current directory"
    fi
fi

echo "Git configuration updated successfully."
echo "Username: $username"
echo "Email: $email"
