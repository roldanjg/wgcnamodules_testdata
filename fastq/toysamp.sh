#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 /path/to/parent_folder"
    exit 1
fi

parent_folder="$1"

find "$parent_folder" -type f -name "*.gz" -exec sh -c '
    for file; do
        folder=$(dirname "$file")
        gunzip -c "$file" | head -n 100000 | gzip > "$folder/first_100000_rows.gz"
        rm "$file"
    done
' sh {} +
