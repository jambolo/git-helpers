# git-helpers
Scripts and aliases that make git easier to use

## Scripts

#### cpp-init-default \<project\>
Sets up a CMake C++ project named _project_ in a subfolder named _project_ and commits it to a new git repo.

#### git-diff-branches \<branch\> \<branch\>
Displays the differences between two branches using difftool.

#### git-difftool-all [path]
Displays the differences for _path_ between the working directory and HEAD all at once using difftool rather than one at a time.

#### git-ffwd
Fetches and fast-forwards (if possible) all branches in the repo.

#### git-ffwd-all
Fetches and fast-forwards (if possible) all branches in the repo and all its submodules.

#### git-pull-branch \<branch\>
Pulls _branch_ and rebases the current branch on top of it.

#### git-pull-if-needed
Pulls the current branch and updates the submodules if the local branch is behind and hasn't diverged.

#### git-rebase-all \<branch\> \<pattern\>
Rebases all branches matching _pattern_ onto _branch_.

For example, I do this a lot: `git-rebase-all develop feature`

#### git-remove-submodule \<path\>
Removes a submodule from the repo completely.

#### git-showtool \<commit\>
Shows the differences between _commit_ and its predecessor using difftool.

#### git-stash-commits \<commit\> [branch]
Resets the current branch to _commit_ and retains the removed commits in a new branch named _branch_.

_Note: The new branch name defaults to the current branch name with '-wip' appended if none is provided._

#### git-status-all
Checks all git repositories in subdirectories, and list the ones with changes.

#### git-sync \<branch1\> \<branch2\>
Unifies two branches such that commits in _branch1_ are followed by commits in _branch2_.

#### git-uncrustify
Runs uncrustify on all modified, added, and deleted (sorry, no choice) c/cpp/h files in the working tree.

#### git-update-all
Fetches and fast-forwards all branches and submodules, and then updates all submodules.

#### julia-init-default \<project\>
Sets up a Julia project named _project_ in a subfolder named _project_ and commits it to a new git repo.

#### node-init-default \<project\>
Sets up a node project named _project_ in a subfolder named _project_ and commits it to a new git repo.

#### rust-init-default \<project\>
Sets up a Rust project named _project_ in a subfolder named _project_ and commits it to a new git repo.

## Aliases
Git commands with options that I use a lot.

* **alias grevert='git checkout --'**: Undoes any unstaged changes to the specified files
* **alias gsquash='git rebase -i'**: Rewrites history
* **alias gunstage='git reset HEAD'**: Unstages the specified files
* **alias ggraph='git log --graph ...**: Draws the branch graph the way that I like it
* **alias glog='git log ...**: Formats the log the way that I like it
* **alias gamend='git commit --amend --no-edit'**: No-fuss amended commits
