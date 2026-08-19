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

## Local Overrides

Create `~/.config/chezmoi/chezmoi.local.toml` for machine-specific values
(see `example.chezmoi.local.toml`):

```toml
[data]
    name = "Your Name"
    email = "you@example.com"
    gitSigningKey = "ssh-ed25519 AAAA..."
```

Access via `{{ .name }}`, `{{ .email }}`, `{{ .gitSigningKey }}`.

## Common Commands

```bash
chezmoi apply          # Apply all changes
chezmoi edit <file>     # Edit source file
chezmoi diff           # Show pending changes
chezmoi status         # Show modified files
```
