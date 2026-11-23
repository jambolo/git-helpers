# git-helpers

Scripts and aliases that make git easier to use

## Scripts

### git-diff-branches \<commit1\> [commit2]

Displays the differences between two branches or commits using difftool. _commit2_ defaults to HEAD.

### git-difftool-all [path]

Displays the differences for _path_ between the working directory and HEAD all at once using difftool rather than one at a time.

### git-ffwd

Fetches and fast-forwards (if possible) all branches in the repo.

### git-ffwd-all

Fetches and fast-forwards (if possible) all branches in the repo and all its submodules.

### git-fetch-all-repos

For all git repositories in any subdirectories, fetches all branches and tags from all remotes.

### git-pull-if-needed

Fetches the upstream of the current branch, then fast-forwards the branch and updates the submodules if it is behind and hasn't diverged. Otherwise reports how many commits it is ahead or behind.

### git-push-wip

Creates a temporary branch named wip/\$\{user\}/\$\{timestamp\} from uncommitted changes and pushes it to origin so that it can be referenced elsewhere.

### git-rebase-all \<branch\> \<pattern\>

Rebases all branches matching _pattern_ onto _branch_.

For example, I do this a lot: `git-rebase-all develop feature`

### git-remove-submodule \<path\>

Removes a submodule from the repo completely.

### git-save-commits \<commit\> [new branch]

Resets the current branch to _commit_ and retains the removed commits in a new branch named _branch_.

_Note: The new branch name defaults to wip/\$\{branch\}-saved-\$\{timestamp\} if none is provided._

### git-showtool \<commit\>

Shows the differences between _commit_ and its predecessor using difftool.

### git-status-all

Checks all git repositories in subdirectories, and list the ones with changes.

### git-sync \<branch1\> \<branch2\>

Unifies two branches such that commits in _branch1_ are followed by commits in _branch2_.

### git-uncrustify

Runs uncrustify on all modified or added c/cpp/h files in the working tree. Set the executable and config file with `git config uncrustify.path` and `git config uncrustify.config`; see `git-uncrustify -h` for the fallbacks.

### git-unpushed-all [-v|--verbose]

Fetches from all remotes, then checks all git repositories in subdirectories recursively and reports branches that have commits not yet pushed to their upstream.

### git-update-all

Fetches and fast-forwards all branches and submodules, and then updates all submodules.

### git-update-rebase \<branch\>

Pulls _branch_ and rebases the current branch on top of it.

### git-update-submodule \<submodule\> | --all

Commits _submodule_ (name or path), or with `--all` every submodule, whose checked-out HEAD differs from the superproject's recorded commit, with a message showing the new short hash. Each submodule is committed separately, and other staged changes are not included.

## Utility Scripts

### update-projects.sh

For each subdirectory that is a Git repository, fetches all remotes, rebases the current branch onto its upstream, and initializes and updates submodules. Skips worktrees and the `3rdParty` and `archived` directories. A detached HEAD, missing upstream, or failed rebase is reported and the branch is left unchanged. A failed fetch, rebase, or submodule update does not stop the remaining repositories, and the exit status is nonzero if anything failed.

## Configuration Files

### my-.gitconfig

Example Git configuration file with custom settings including:

- Core settings (preload index, file system cache, editor configuration)
- Git LFS filter configuration
- User identity settings
- Diff and merge tool settings (Araxis Merge)

To use this configuration, copy it to your user directory and adjust the paths and user information as needed.

### my-.npmrc

Example NPM configuration file with settings for initializing new npm projects, including:

- Author email
- Author name
- Author URL
- License type
- Project version

## Aliases

Git commands with options that I use a lot.

- **alias grevert='git checkout --'**: Undoes any unstaged changes to the specified files
- **alias gsquash='git rebase -i'**: Rewrites history
- **alias gunstage='git reset HEAD'**: Unstages the specified files
- **alias ggraph='git log --graph ...**: Draws the branch graph the way that I like it
- **alias glog='git log ...**: Formats the log the way that I like it
- **alias gamend='git commit --amend --no-edit'**: No-fuss amended commits
