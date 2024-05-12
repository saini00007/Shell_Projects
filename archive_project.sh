#!/bin/bash

# Define the folder to analyze
folder="/home/kali/Desktop/volatility3/"

mkdir$folder/archive
# Define the folder to move compressed files
destination_folder=$folder/archive

# Get current date
current_date=$(date +%s)

# Loop through files in the folder
for file in "$folder"/*
do
    # Check if the file exists and is a regular file
    if [[ -f "$file" ]]; then
        # Get last modified date of the file
        modified_date=$(stat -c %Y "$file")

        # Calculate the difference in seconds between current date and last modified date
        time_diff=$((current_date - modified_date))
        
        # Check if the file is older than one month (approximately 30 days)
        if [[ $time_diff -gt 2592000 ]]; then
            # Delete the file
            rm "$file"
            echo "Deleted $file"
        fi

        # Check if the file size is larger than 30MB
        if [[ $(stat -c %s "$file") -gt 31457280 ]]; then
            # Compress the file into a zip archive
            zip_file="$destination_folder/$(basename "$file").zip"
            zip -j "$zip_file" "$file"
            echo "Compressed $file into $zip_file"

            # Optionally, remove the original file
            # rm "$file"
            # echo "Deleted $file"
        fi
    fi
done

