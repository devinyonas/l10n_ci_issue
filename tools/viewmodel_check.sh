#!/bin/bash

# Find all Dart files in the project, excluding the 'test' folder
dart_files=$(find . -name '*.dart' -not -path "./test/*")

# Iterate through each Dart file
for file in $dart_files; do

  # Checks if the file itself ends with '_viewmodel.dart'
  if [[ "$file" == *"_viewmodel.dart" ]]; then

    # Check if the file contains the substring 'import' followed by '_viewmodel.dart'
    imports=$(grep -F '_viewmodel.dart' "$file")

    # If imports are found, print an error message
    if [ -n "$imports" ]; then
      echo "Error: ViewModel '$file' imports another ViewModel $imports."
      exit 1
    fi
    
  fi
done

echo "No view model dependencies found."
