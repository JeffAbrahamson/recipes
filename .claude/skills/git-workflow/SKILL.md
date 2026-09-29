---
name: git-workflow
description: Git hygiene rules for this repo — worktrees, when to commit autonomously vs. ask first, destructive operations, staging new files, and git vs. GitHub. Read before committing, creating/using a worktree, or any git operation beyond a plain status/diff/log.
---

## Worktrees

Never `cd` into another worktree (or clone) and chain a command, e.g.
`cd ../some-worktree && git ...` — this pattern can silently run
against the wrong branch. Use `git -C <path> ...` or a dedicated
worktree tool instead. This applies even though this repo currently
has no extra worktrees active — they can get spun up ad hoc later.

## Staging new files

`git add --intent-to-add` new files as soon as they're created — right
after the Write that creates them, not batched at commit time — so
`git status`/`git diff` show that the file exists and needs reviewing,
rather than it sitting untracked and easy to miss.

## Review before commit

Before proposing a commit for anything beyond a trivial one-line
change, re-read the diff once against `CLAUDE.md`'s recipe conventions
(tone/word-economy rules, ingredient ordering, macro usage) and confirm
the build-log check above has been done. This repo's content is plain
LaTeX recipe text with no application logic, so unless the change is
unusually tricky (new macros, structural changes to `recipe-macros.tex`
or the build pipeline), this review is a good candidate for a
cheaper/faster model rather than the primary one doing the edit.

## When to commit

Ask before committing by default. It's fine to commit without asking
mid-task when the user's own request already implies it (e.g. "add
this recipe and commit it," or a multi-step request that explicitly
includes committing along the way). The agent's own commits go through
the same review as anyone else's — no special-casing.

Use the `git-commit` skill for message formatting; this project's
`CLAUDE.md` also states a lighter convention for simple recipe
additions ("Improved X" is often enough) — follow that over the
skill's fuller why/approach/tradeoffs template when the change really
is that small.

## Destructive operations

Force-push, `reset --hard`, history rewrites, and amending
already-pushed commits require explicit user sign-off each time — not
inferred from an earlier approval of a similar action.

## git vs. GitHub

Most work here is local commits to `main`. This repo has no PR/CI
workflow in practice (direct pushes to `origin/main`). Anything that
touches GitHub itself — pushing, issues, `gh` — needs specific
authorisation in the prompt or via a direct question; prefer the local
equivalent when one exists (e.g. `git merge --ff-only` over `gh pr
merge`).

## Push policy

Never run `git push` in any form, including to the agent's own branch,
unless the prompt explicitly asks for it — approval for one push
doesn't carry over to the next. An authorised force-push is always
`git push --force-with-lease`, never bare `--force`/`-f`.
