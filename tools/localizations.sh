#!/bin/bash

# Define the path to the l10n_errors.txt file
FILE_PATH="./l10n_errors.txt"

# Check if the file exists
if [ -f "$FILE_PATH" ]; then
    # Read the contents of the file
    FILE_CONTENT=$(cat "$FILE_PATH")

    # Check if the file is empty (contains only "{}")
    if [ "$FILE_CONTENT" == "{}" ]; then
        echo "No missing localization keys found."
    else
        echo "Missing localization keys found:"
        echo "$FILE_CONTENT"
        exit 1
    fi
else
    echo "File not found: $FILE_PATH"
fi
