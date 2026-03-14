# Dotfiles

macOS developer configuration files following the [XDG Base Directory](https://specifications.freedesktop.org/basedir-spec/latest/) specification.

---

## How this works (read this first)

### Where do your config files actually live?

After running `install.sh`, `~/.config` becomes a symlink pointing to `~/dotfiles/.config`:

```
~/.config  →  ~/dotfiles/.config   (symlink)
```

This means **you only ever edit files in one place**: `~/.config/` (or equivalently `~/dotfiles/.config/` — they are the same directory). Any edit is automatically inside the git repo.

### Two repos, two workflows

This dotfiles repo has **Neovim as a git submodule** (`aladinoster/config.nvim`), because it's also used independently on other machines. Everything else lives directly in this repo.

| Config | Repo | Where to edit |
|--------|------|---------------|
| tmux, zsh, git, lazygit, etc. | `aladinoster/dotfiles` | `~/.config/<tool>/` |
| Neovim | `aladinoster/config.nvim` | `~/.config/nvim/` |

### Pushing changes

**Non-nvim configs** (tmux, zsh, brew.sh, etc.):
```bash
cd ~/dotfiles
git add -A
git commit -m "update tmux config"
git push
```

**Neovim config** — two steps (push nvim, then update the pointer in dotfiles):
```bash
# Step 1: push nvim changes to config.nvim
cd ~/.config/nvim
git add -A && git commit -m "add plugin xyz" && git push

# Step 2: record the new nvim commit in dotfiles
cd ~/dotfiles
git add .config/nvim
git commit -m "chore: bump nvim submodule"
git push
```

Or use the `nvim-push` shell function (defined in `config.d/tools.zsh`) to do both in one shot:
```bash
nvim-push "add plugin xyz"
```

### Syncing Neovim from another machine

If you made nvim changes on your other laptop and pushed them to `config.nvim`:
```bash
# Pull the latest nvim commits into this machine's submodule
cd ~/dotfiles
git submodule update --remote .config/nvim

# Record the updated pointer
git add .config/nvim
git commit -m "chore: sync nvim from other machine"
git push
```

### Pulling dotfiles updates on another machine

```bash
cd ~/dotfiles
git pull
git submodule update --init --recursive   # also pull latest nvim
```

---

## What's included

| Tool | Location | Description |
|------|----------|-------------|
| **Zsh** | `.config/zsh/` | Oh My Zsh + Powerlevel10k, modular config.d |
| **Tmux** | `.config/tmux/` | TPM plugins, Catppuccin theme, vim-tmux-navigator |
| **Neovim** | `.config/nvim/` | Lazy.nvim, LSP, DAP, Telescope, Harpoon, REPL (slime/iron) |
| **Git** | `.config/git/` | Aliases, LFS, nvim editor |
| **Lazygit** | `.config/lazygit/` | TUI Git client config |
| **Marimo** | `.config/marimo/` | Reactive Python notebook config |
| **Htop** | `.config/htop/` | Process viewer config |
| **GH CLI** | `.config/gh/` | GitHub CLI config |

## Prerequisites

1. Install [Homebrew](https://brew.sh/):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. Install [Oh My Zsh](https://ohmyzsh.sh/):
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

3. Install [Rust](https://rustup.rs/) (optional, needed for cargo):
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

## Installation

```bash
# 1. Clone the repository
git clone https://github.com/aladinoster/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Install packages
chmod +x brew.sh && ./brew.sh

# 3. Create symlinks
chmod +x install.sh && ./install.sh

# 4. Restart your terminal
exec zsh
```

## Tmux plugins

After linking configs, install [TPM](https://github.com/tmux-plugins/tpm) plugins:

```bash
# TPM is auto-installed by install.sh, then inside tmux:
<prefix> + I   # Install plugins
<prefix> + U   # Update plugins
```

**Plugins included:**
- `tmux-sensible` — sensible defaults
- `tmux-resurrect` + `tmux-continuum` — session persistence
- `tmux-yank` — clipboard integration
- `tmux-sessionx` — fuzzy session picker (`<prefix> + O`)
- `vim-tmux-navigator` — seamless pane/split switching with Neovim
- `catppuccin/tmux` — Mocha theme

## Neovim

Neovim config uses [Lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management. It auto-installs on first run.

See [`.config/nvim/README.md`](.config/nvim/README.md) for full keybindings reference.

**Key plugins:** Telescope, Treesitter, LSP (Mason), DAP, Harpoon, Oil, Slime/Iron REPL, Noice, TokyoNight, Obsidian, Neorg.

## Zsh structure

```
.config/zsh/
├── .zshrc          # Main config (Oh My Zsh, plugins, history)
├── .p10k.zsh       # Powerlevel10k prompt config
└── config.d/       # Modular configs (auto-sourced)
    ├── exports.zsh  # PATH, EDITOR, language managers (pyenv, cargo, bun)
    ├── nvm.zsh      # Node Version Manager
    ├── tools.zsh    # Aliases, fzf config, helper functions
    └── secrets.zsh  # Private exports (NOT tracked in git)
```

`.zshenv` (at `$HOME`) sets `ZDOTDIR=$HOME/.config/zsh` and `XDG_CONFIG_HOME`.

## Repository structure

```
dotfiles/
├── .zshenv          # Sets ZDOTDIR and XDG_CONFIG_HOME
├── .aliases         # Git, docker shortcuts
├── brew.sh          # Package installation
├── install.sh       # Symlink setup
└── .config/
    ├── git/
    ├── nvim/
    ├── tmux/
    ├── zsh/
    ├── lazygit/
    ├── marimo/
    ├── htop/
    └── gh/
```
