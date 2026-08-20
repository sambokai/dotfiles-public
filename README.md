# Dotfiles

Cross-platform dotfiles managed by [chezmoi](https://chezmoi.io/) for macOS and Linux.

## What's included

- zsh + bash with Powerlevel10k, zplug, fzf, zoxide, eza, bat
- git config (delta, lazygit) with per-machine identity
- Homebrew package management (Brewfile)
- Editor/terminal configs: Zed, Warp, OpenCode
- One-shot install scripts (Homebrew, zsh, Node via pnpm)

## Setup

One command (installs chezmoi, clones this repo, and applies everything):

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply <github-username>/dotfiles-public
```

On first run, chezmoi prompts for your name and email and stores them in
`~/.config/chezmoi/chezmoi.toml` (it won't ask again).

> Note: the repo must be public (or your machine must have GitHub access)
> for `chezmoi init` to clone it.

### Optional: git commit signing

Commit signing is disabled by default and left for you to configure per
machine. Put your signing setup (SSH or GPG) in `~/.gitconfig.local`, which
is already included by the generated git config.

## Customization

- `dot_Brewfile.tmpl` — Homebrew formulae and casks.
- `.chezmoi.toml.tmpl` — generates the config file; prompts for `name` and
  `email` on first init.
- `~/.config/chezmoi/chezmoi.toml` — per-machine `[data]`
  (`name`, `email`, optional `gitSigningKey`).

## Notes

- No secrets or personal data are stored in this repo. Identity is prompted
  for on first run and stored in the gitignored `~/.config/chezmoi/chezmoi.toml`.
