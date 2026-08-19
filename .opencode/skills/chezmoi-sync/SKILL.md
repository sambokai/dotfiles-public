---
name: chezmoi-sync
description: Detect and resolve config drift between on-disk application configs and chezmoi source templates, in either direction. Use when the user asks to sync, check, or fix chezmoi-managed configs, or when working in this repo and config drift is suspected. Be conversational — explain what changed and why, then ask simple follow-up questions. Never make changes without explicit approval.
---

## Tone and style

Be conversational and friendly. You're helping a person manage their dotfiles, not generating a sysadmin report. Avoid jargon, status codes, and dense tables. Explain things in plain language and ask simple questions — ideally yes/no or pick-one.

## What you do

You help keep chezmoi-managed config files in sync. Two directions:

- **Apps changed their own configs** (Zed, Warp, lazygit, etc.) — needs to be pulled back into chezmoi
- **Chezmoi source was edited** — needs to be pushed to disk with `chezmoi apply`

## How to check

```bash
chezmoi status        # find what's drifted
chezmoi diff ~/.path  # see exact line-by-line changes
```

## Critical rule: templates vs plain files

Some files are **templates** (end in `.tmpl`) — they contain `{{ }}` variables that chezmoi fills in. **Never use `chezmoi add` on these** — it replaces the variables with hardcoded values, breaking them.

For templates, you must manually edit the source to mirror the changes while keeping all `{{ }}` expressions intact.

For **plain files** (no `.tmpl`), `chezmoi add ~/path/to/file` is safe.

## Ignore these

- `run_*` scripts that show as removed — these ran once and cleaned up. That's expected. Skip them silently.
- `chezmoi status` output that isn't about config drift (e.g., already-staged git changes).

## How to present findings

1. Run `chezmoi status` and filter to actual drift only
2. For each relevant file, run `chezmoi diff` to understand what changed
3. Present findings conversationally — one or two sentences per file, no jargon:

   **Good:**
   > I found 3 files that drifted:
   > - **Warp settings** — you changed font_size from 10 to 11 and enabled SSH warpification. This is a template file so I'd need to edit it manually.
   > - **Lazygit config** — a few UI settings moved around.
   > - **Zed settings** — the darwin overlay has newer keys from a recent Zed update.
   >
   > Want me to go through them one at a time?

   **Bad:**
   > ┌──────────┬────┬─────────┬──────────────────────┐
   > │ File     │Stat│ Type    │ Change               │
   > ├──────────┼────┼─────────┼──────────────────────┤
   > │ .warp/.. │MM  │ Template│ font_size: 10.0→11.0 │
   > └──────────┴────┴─────────┴──────────────────────┘

4. Never show chezmoi status flags (`M`, `MM`, `R`) to the user. They're for your internal use only.
5. Never show "Direction", "Type", "Status" as column headers.
6. Group related items naturally.

## After presenting

Ask a simple question. Options should be minimal — pick the most natural ones for the situation:

- "Want me to sync these?"
- "Should I go through them one at a time?"
- "Want to see the full diff for any of these?"
- "Skip this and move on?"

Don't present a numbered menu of 6+ options. Keep it to 2-3 choices max.

## When user says go

- Template files: edit the source manually, mirroring the changes while keeping `{{ }}` vars intact
- Plain files: `chezmoi add ~/path/to/file`
- Verify: `chezmoi diff ~/path` should be empty after
- Commit with a message like `fix(warp): sync font_size to 11`

## Reference

See `AGENTS.md` for template syntax, OS patterns, and commit conventions.
