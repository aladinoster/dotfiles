#!/usr/bin/env bash
# macOS Homebrew package installation
# Run: chmod +x brew.sh && ./brew.sh

set -e

echo "Installing Homebrew packages..."

# ── Terminal & Shell ──────────────────────────────────────────────────────────
brew install zsh
brew install zsh-autosuggestions
brew install zsh-git-prompt
brew install zsh-syntax-highlighting
brew install zsh-completions

# ── Core Dev Tools ────────────────────────────────────────────────────────────
brew install git
brew install git-flow
brew install git-lfs
brew install gh
brew install lazygit
brew install tmux
brew install fzf
brew install bat
brew install ripgrep
brew install glow          # Markdown terminal reader (used in fzf previews)
brew install tree
brew install htop
brew install neovim
brew install just          # Command runner (justfile)
brew install hugo

# ── Languages & Runtimes ─────────────────────────────────────────────────────
brew install nvm
brew install uv            # Fast Python package manager
brew install go
brew install lua
brew install python@3.12

# ── AI Tools ─────────────────────────────────────────────────────────────────
brew install gemini-cli
# claude-code is installed as a cask (see below)

# ── Fonts ─────────────────────────────────────────────────────────────────────
brew install --cask font-hack-nerd-font
brew install --cask font-fira-code-nerd-font
brew install --cask font-source-code-pro

# ── Applications ──────────────────────────────────────────────────────────────
brew install --cask zed
brew install --cask claude-code
brew install --cask visual-studio-code
brew install --cask docker
brew install --cask obsidian
brew install --cask zotero

# ── Optional Applications (uncomment as needed) ───────────────────────────────
# brew install --cask notion
# brew install --cask slack
# brew install --cask spotify
# brew install --cask dropbox
# brew install --cask gifox
# brew install --cask miniconda

# ── Optional Tools ────────────────────────────────────────────────────────────
# brew install --cask julia
# brew install --cask mactex

echo "Done! Restart your terminal."
