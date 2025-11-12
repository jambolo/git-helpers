#!/usr/bin/env bash


# Goes into each subdirectory with a Git repo and does a pull and a submodule update

for d in *; do
        if [ -d "$d" ] && [ "$d" != "3rdParty" ]; then
                pushd "$d" 1> /dev/null
                if git rev-parse --git-dir > /dev/null 2>&1; then
                        echo "> $d"
                # Fetch all branches and tags from all remotes, prune obsolete branches, and merge the current branch
                git fetch --all --tags --prune
                        if git rev-parse @{u} > /dev/null 2>&1; then
                                git merge "$(git rev-parse --abbrev-ref --symbolic-full-name @{u})"
                        fi
                        # Update submodules
                        git submodule update --recursive
                        echo ""
                fi
                popd 1> /dev/null
        fi
done