# Chezmoi Dotfiles

Managed via chezmoi. Source files are templates (`.tmpl`) that render to the home directory.

## OS Support
- macOS (`.chezmoi.os` == `darwin`)
- Linux (`.chezmoi.os` == `linux`)

## Key Patterns

| Prefix | Behavior |
|--------|----------|
| `dot_` | Render to `~/.filename` (hidden) |
| `run_once_` | Execute once, never again (idempotent) |
| `run_onchange_` | Execute when file content changes |
| `.tmpl` | Template file (processed by chezmoi) |

## Notes for AI Agents

- When the user refers to `cm`, they mean `chezmoi`.
- This repo must never contain secrets or personal data (see `.gitignore`).

## Template Syntax

```text
{{ .chezmoi.os }}          # "darwin" or "linux"
{{ .chezmoi.hostname }}     # hostname
{{ .chezmoi.username }}     # username
{{- "..." | includeTemplate }} # include another template
```

## Identity / Data

`.chezmoi.toml.tmpl` generates `~/.config/chezmoi/chezmoi.toml` and prompts
for `name` and `email` on `chezmoi init`. These become template variables
`{{ .name }}` and `{{ .email }}`.

Optional `gitSigningKey` (for SSH-signed commits) can be added manually to the
`[data]` section of `~/.config/chezmoi/chezmoi.toml`; when present it's read
via `{{ .gitSigningKey }}`.

## Common Commands

```bash
chezmoi apply          # Apply all changes
chezmoi edit <file>     # Edit source file
chezmoi diff           # Show pending changes
chezmoi status         # Show modified files
```
