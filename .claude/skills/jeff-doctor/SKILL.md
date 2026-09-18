---
name: jeff-doctor
description: Audit this project against Jeff's cross-project engineering and AI-agent conventions. Use when the user runs /jeff-doctor or asks for a conformity check against his standard practices.
user-invocable: true
allowed-tools: Bash(git:*), Read, Grep, Glob
---

## Source of truth

The checklist lives outside this project, at:

    /home/jeff/src/jma/AI/jeff-doctor.md

Always read it live at invocation time — never vendor a copy into this
project. The audit must run against whatever that file currently says.

## Before running the checklist

Check that the local `AI` clone is exactly `origin/main`:

1. `git -C /home/jeff/src/jma/AI fetch`
2. Compare `git -C /home/jeff/src/jma/AI rev-parse HEAD` against
   `git -C /home/jeff/src/jma/AI rev-parse origin/main`
3. Check for a clean working tree: `git -C /home/jeff/src/jma/AI status --porcelain`

If HEAD differs from `origin/main`, or the tree isn't clean, warn the
user loudly and explicitly (checked out to a different branch/commit,
ahead/behind `origin/main`, or has local edits) before proceeding —
the report must never be silently produced against a stale or
unreviewed version of the checklist.

## Running the audit

Read `/home/jeff/src/jma/AI/jeff-doctor.md` in full and follow its
"What to do" section exactly: read this project's `CLAUDE.md` /
`AGENTS.md` / `.claude/` contents, skim the codebase and recent git
history for real practice (not just documented practice), compare
against the checklist, and report back as a conformity report (Met /
Partial / Missing / Not applicable per item, one line of evidence
each) followed by a prioritised list of concrete gaps.

Do not make changes to the project unless the user separately asks —
this skill produces a report and a plan, not edits.
