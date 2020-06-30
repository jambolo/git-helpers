# git-helpers
Scripts and aliases that make git easier to use

## Scripts

#### git-diff-branches
Displays the differences between two branches using difftool

    git-diff-branches <branch> <branch>

#### git-difftool-all
Displays the differences for <path> between the working directory and HEAD using difftool

    git-difftool-all [path]

#### git-ffwd
Fetches and fast-forwards (if possible) all branches in the repo

    git-ffwd

#### git-ffwd-all
Fetches and fast-forwards (if possible) all branches in the repo and all its submodules

    git-ffwd-all

#### git-pull-branch
Pulls <branch> and rebases the current branch on top of it

    git-pull-branch <branch>

#### git-pull-if-needed
Pulls the current branch is pulled and updates the submodules if the local branch is behind and hasn't diverged

    git-pull-if-needed

#### git-rebase-all
Rebases all branches matching <pattern> onto <branch>

    git-rebase-all <branch> <pattern>

For example, I do this a lot: `git-rebase-all develop feature`

#### git-remove-submodule
Removes a submodule from the repo completely

    git-remove-submodule <path>

#### git-showtool
Shows the differences between a commit and its predecessor using difftool

    git-showtool <commit>

#### git-stash-commits
Resets the current branch to the specified commit and moves the removed commits to a new branch."

    git-stash-commits <commit> [<branch>]

Note: The new branch name defaults to the current branch name with '-wip' appended if none is provided.

#### git-status-all
Checks all git repositories in subdirectories, and list the ones with changes

#### git-sync
Unifies two branches such that commits in <branch1> are followed by commits in <branch2>.

    git-sync <branch1> <branch2>

#### git-uncrustify
Runs uncrustify on all modified, added, and deleted (sorry, no choice) c/cpp/h files in the working tree.

    git-uncrustify

#### git-update-all
Fetches and fast-forwards all branches and submodules, and then updates all submodules

    git-update-all

## Aliases
Git commands with options that I use a lot

* alias grevert='git checkout --': Undoes any unstaged changes to the specified files
* alias gsquash='git rebase -i': Rewrites history
* alias gunstage='git reset HEAD': Unstages the specified files
* alias ggraph='git log --graph ...: Draws the branch graph the way that I like it
* alias glog='git log ...: Formats the log the way that I like it
* alias gamend='git commit --amend --no-edit': No-fuss amended commits
