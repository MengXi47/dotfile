---
name: commit-push
description: Commit all staged and unstaged changes then push to remote, following project git-workflow rules.
---

# Commit + Push

Commit all changes and push to remote in one step. Follows the git-workflow rules for commit message format.

## Workflow

Execute these steps in order:

### 1. Check status and diff (parallel)

Run in parallel:
- `git status` to see all changed and untracked files
- `git diff` to see unstaged changes
- `git diff --cached` to see staged changes
- `git log --oneline -5` to see recent commit message style

### 2. Validate

- If there are no changes (no untracked, no modified, no staged), inform the user and stop.
- Do NOT commit files that likely contain secrets (`.env`, `credentials.json`, etc.). Warn the user if found.

### 3. Stage files

- Only stage files that were modified by Claude in the current conversation. Do NOT commit pre-existing changes or unrelated files.
- If the user explicitly asks to include other files, then include them.
- Add files by name. Do NOT use `git add -A` or `git add .`.

### 4. Draft commit message

Follow the commit message format from rules:

```
<type>: <description>

<optional body>
```

- **Types:** `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `perf`, `ci`
- Summarize the nature of the changes. Use the correct type:
  - `feat` = wholly new feature
  - `fix` = bug fix
  - `refactor` = code restructuring without behavior change
  - `docs` = documentation only
  - `test` = test only
  - `chore` = maintenance
  - `perf` = performance improvement
  - `ci` = CI/CD changes
- Write the description in the language matching the codebase (this project uses Traditional Chinese).
- Keep the first line concise. Add a body only if the change needs explanation.
- Do NOT add `Co-Authored-By` lines (attribution disabled in settings).

### 5. Commit

Use a HEREDOC to pass the commit message:

```bash
git commit -m "$(cat <<'EOF'
<type>: <description>

<optional body>
EOF
)"
```

### 6. Push

- Run `git push`.
- If rejected (remote has new commits), run `git pull --rebase` then `git push`.
- If the branch has no upstream, use `git push -u origin <branch>`.

### 7. Confirm

Report the commit hash and confirm push succeeded.

## Rules

- NEVER use `git add -A` or `git add .`
- NEVER skip hooks (`--no-verify`)
- NEVER amend previous commits — always create NEW commits
- NEVER force push
- NEVER commit secrets
- Always create a NEW commit, even after hook failures
