#!/usr/bin/env bash
# version: 2.1.0
#
# Goes into each subdirectory that is a Git repo, fetches all remotes, rebases the current branch onto its upstream, and
# updates submodules. Repos whose upstream is archived on GitHub are then moved into the archived directory.

set -e  # Exit on error

usage() {
    echo "Usage: update-projects.sh"
    echo "For each subdirectory that is a git repo, fetches all remotes, rebases the current branch onto its upstream,"
    echo "and updates submodules. Repos whose upstream is archived on GitHub are then moved into archived/."
    echo "Skips worktrees and the 3rdParty and archived directories."
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

# Prints owner/name of the upstream's GitHub repo, or nothing if the upstream is not on GitHub
github_repo() {
    local remote url
    remote=$(git config "branch.$(git branch --show-current).remote") || return 0
    url=$(git remote get-url "$remote") || return 0
    case "$url" in
        git@github.com:*|https://github.com/*|ssh://git@github.com/*) ;;
        *) return 0 ;;
    esac
    url=${url#*github.com[:/]}
    echo "${url%.git}"
}

have_gh=1
if ! command -v gh > /dev/null; then
    echo "Warning: gh not found; not checking for archived repos." >&2
    have_gh=0
fi

for d in */; do
    d=${d%/}
    case "$d" in
        3rdParty|archived) continue ;;
    esac

    # Skip non-repos, worktrees, and submodules, which have a .git file instead of a directory
    [ -d "$d/.git" ] || continue

    echo "> $d"
    pushd "$d" > /dev/null
    before=$status

    if ! git fetch --all --tags --prune --force; then
        error "fetch failed in $d."
    fi

    rebase_onto_upstream "$d"

    if ! git submodule update --init --recursive; then
        error "submodule update failed in $d."
    fi

    # Check for an archived GitHub repo only if the update succeeded
    archive=0
    if [ $have_gh -eq 1 ] && [ $status -eq $before ]; then
        repo=$(github_repo)
        if [ -n "$repo" ]; then
            if ! archived=$(gh repo view "$repo" --json isArchived -q .isArchived); then
                error "could not query GitHub for $repo."
            elif [ "$archived" = true ]; then
                archive=1
            fi
        fi
    fi

    popd > /dev/null

    if [ $archive -eq 1 ]; then
        if [ -e "archived/$d" ]; then
            error "archived/$d already exists; not moving $d."
        elif mkdir -p archived && mv "$d" archived/; then
            echo "- $repo is archived on GitHub; moved $d to archived/."
        else
            error "could not move $d to archived/."
        fi
    fi
    echo
done

exit $status
