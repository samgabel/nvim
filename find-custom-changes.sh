#!/bin/bash

# Navigate to the top-level directory

LAZY_DIR=/Users/${USER}/.local/share/nvim/lazy
cd $LAZY_DIR

# Loop through all subdirectories
for dir in */; do
    if [ -d "$dir/.git" ]; then
        # Change to the repository directory
        cd "$dir"

        # Check for modifications outside of doc/ directory and that aren't package-lock changes
        if git status --porcelain | grep -v '^.. doc/' | grep -v 'package-lock.json' | grep -v 'yarn.lock' | grep -q '^'; then
            echo "Modified: $LAZY_DIR/$dir"
        fi

        # Return to the parent directory
        cd ..
    fi
done
