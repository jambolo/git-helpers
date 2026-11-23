#!/usr/bin/env bash
# version: 2.0.0
#
# Goes into each subdirectory that is a Git repo, fetches all remotes, rebases the current branch onto its upstream, and
# updates submodules.

set -e  # Exit on error

usage() {
    echo "Usage: update-projects.sh"
    echo "For each subdirectory that is a git repo, fetches all remotes, rebases the current branch onto its upstream,"
    echo "and updates submodules. Skips worktrees and the 3rdParty and archived directories."
}

case "$1" in
    -h|--help) usage; exit 0 ;;
esac

if [ $# -ne 0 ]; then
    usage >&2
    exit 1
fi

status=0

# Prints an error and records the failure
error() {
    echo "Error: $1" >&2
    status=1
}

# Rebases the current branch onto its upstream, aborting the rebase if it fails
rebase_onto_upstream() {
    local d=$1
    if ! git symbolic-ref -q HEAD > /dev/null; then
        error "$d is on a detached HEAD; not pulling."
    elif ! git rev-parse -q --verify '@{u}' > /dev/null 2>&1; then
        error "branch $(git branch --show-current) in $d has no upstream or its upstream is gone; not pulling."
    elif [ -d "$(git rev-parse --git-path rebase-merge)" ] || [ -d "$(git rev-parse --git-path rebase-apply)" ]; then
        error "$d has a rebase in progress; not pulling."
    elif ! git rebase; then
        git rebase --abort 2> /dev/null || true
        error "rebase failed in $d; left unchanged."
    fi
}

for d in */; do
    d=${d%/}
    case "$d" in
        3rdParty|archived) continue ;;
    esac

    # Skip non-repos, worktrees, and submodules, which have a .git file instead of a directory
    [ -d "$d/.git" ] || continue

    echo "> $d"
    pushd "$d" > /dev/null

    if ! git fetch --all --tags --prune --force; then
        error "fetch failed in $d."
    fi

    rebase_onto_upstream "$d"

    if ! git submodule update --init --recursive; then
        error "submodule update failed in $d."
    fi

    popd > /dev/null
    echo
done

exit $status
