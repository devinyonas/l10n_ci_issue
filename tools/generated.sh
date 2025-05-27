#!/bin/bash

dart run build_runner build --delete-conflicting-outputs

sleep 5s

# Check if there are any differences

changes=$(git diff --ignore-all-space --ignore-blank-lines --ignore-space-at-eol --ignore-space-change | grep -vE "^(old|new) mode" | grep -vE "^diff --git a/tools/generated.sh")


echo "Changes detected (excluding file mode changes):"
echo "$changes"

if [[ -n "$changes" ]]; then
    echo "Error: Uncommitted changes detected. Please commit your changes and try again."
    exit 1
fi
