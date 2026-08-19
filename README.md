# Dotfiles

Cross-platform dotfiles managed by [chezmoi](https://chezmoi.io/) for macOS and Linux.

## What's included

- zsh + bash with Powerlevel10k, zplug, fzf, zoxide, eza, bat
- git config (delta, lazygit) with per-machine identity
- Homebrew package management (Brewfile)
- Editor/terminal configs: Zed, Warp, OpenCode
- One-shot install scripts (Homebrew, zsh, Node via pnpm)

## Setup

1. Install chezmoi:

   ```bash
   sh -c "$(curl -fsLS get.chezmoi.io)"
   ```

2. Initialize from this repo and apply:

   ```bash
   chezmoi init <github-username>/dotfiles
   chezmoi apply
   ```

3. Set your identity. Copy the example config and fill in your details:

   ```bash
   mkdir -p ~/.config/chezmoi
   cp example.chezmoi.local.toml ~/.config/chezmoi/chezmoi.local.toml
   # edit name / email (and optionally gitSigningKey), then re-apply
   chezmoi apply
   ```

4. Add any machine-specific git overrides to `~/.gitconfig.local`
   (e.g. a signing program or proxy settings).

## Customization

- `dot_Brewfile.tmpl` — Homebrew formulae and casks.
- `~/.config/chezmoi/chezmoi.local.toml` — per-machine `[data]`
  (`name`, `email`, optional `gitSigningKey`).

## Notes

- No secrets or personal data are stored in this repo. Identity is provided
  per-machine via `~/.config/chezmoi/chezmoi.local.toml` (gitignored).
