# Git Bash Cheat Sheet

## Get all commits that affected the file

```bash
git log --follow <file>
```

## Compare file between different branches

```bash
git diff <previous branch> <current branch> -- <file>
```

## Show changes that a particular commit did to a file

```bash
git diff <commit id>^ <commit id> -- <file>
```

## Show all changes that have been staged for the next commit

```bash
git diff --cached
```

## Track a file change

```bash
git add <files> 
```

## Untrack a file change

```bash
git reset <files>
```

## Commit tracked file changes

```bash
git commit -m "<message>"
```

## Discard all untracked changes

```bash
git checkout -- .
```

## Update remote branch
```bash
git push
```

## Merge new commits from remote branch
```bash
git pull
```

## Rebase new commits from remote branch
```bash
git pull -r
```

## Fork a new branch B from branch A

```bash
git checkout -b <branch B> <branch A>
git push --set-upstream origin <branch B>`
```

## Fetch a remote PR with the given ID as BRANCHNAME
```bash
git fetch origin pull/ID/head:BRANCHNAME
```

## Switch branch

```bash
git checkout <branch>
```

## Delete branch A

```bash
git push -d origin <branch A>
git branch -d <branch A>
```

## Deletes all stale remote-tracking branches


```bash
git remote prune origin
```

## Apply commit x on branch A

```bash
git checkout <branch A>
git cherry-pick <id of commit x>
```
