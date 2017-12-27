### get all commits that affected the file
git log --follow <file>

### compare file between different branches
git diff <previous branch> <current branch> -- <file>

### track file change
git add <files> 

### untrack file change
git reset <files>

### commit tracked file changes
git commit -m "<message>"
git push

### discard all untracked changes
git checkout -- .

### create a new branch
git checkout -p <branch>
git push --set-upstream origin <branch>

### switch branch
git checkout <branch>
git pull

### delete branch A
git push -d origin <branch A>
git branch -d <branch A>

### apply commit x on branch A
git checkout <branch A>
git cherry-pick <id of commit x>