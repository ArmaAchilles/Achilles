### get all commits that affected the file
```bash
git log --follow <file>
```
### compare file between different branches
```bash
git diff <previous branch> <current branch> -- <file>
```
### track file change
```bash
git add <files> 
```
### untrack file change
```bash
git reset <files>
```
### commit tracked file changes
```bash
git commit -m "<message>"
git push
```
### discard all untracked changes
```bash
git checkout -- .
```
### create a new branch
```bash
git checkout -b <branch>
git push --set-upstream origin <branch>`
```
### switch branch
```bash
git checkout <branch>
git pull`
```
### delete branch A
```bash
git push -d origin <branch A>
git branch -d <branch A>
```
### apply commit x on branch A
```bash
git checkout <branch A>
git cherry-pick <id of commit x>
```
