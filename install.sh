#!/usr/bin/env bash
# Dotfiles installation script
# Creates symlinks from ~/dotfiles into the appropriate system locations
# Run: chmod +x install.sh && ./install.sh

set -e

DOTFILES="$HOME/dotfiles"
CONFIG="$HOME/.config"

echo "Installing dotfiles from $DOTFILES..."

# ── Submodules ────────────────────────────────────────────────────────────────
echo "Initializing submodules..."
git -C "$DOTFILES" submodule update --init --recursive

# ── Helper ────────────────────────────────────────────────────────────────────
link() {
  local src="$1"
  local dst="$2"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "  Backing up $dst → ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -sf "$src" "$dst"
  echo "  Linked: $dst → $src"
}

# ── Home dotfiles ─────────────────────────────────────────────────────────────
link "$DOTFILES/.zshenv" "$HOME/.zshenv"
link "$DOTFILES/.aliases" "$HOME/.aliases"

# ── XDG Config ────────────────────────────────────────────────────────────────
mkdir -p "$CONFIG"

# Git
link "$DOTFILES/.config/git/config" "$CONFIG/git/config"
link "$DOTFILES/.config/git/ignore" "$CONFIG/git/ignore"

# Zsh
link "$DOTFILES/.config/zsh/.zshrc"           "$CONFIG/zsh/.zshrc"
link "$DOTFILES/.config/zsh/.p10k.zsh"        "$CONFIG/zsh/.p10k.zsh"
link "$DOTFILES/.config/zsh/config.d"         "$CONFIG/zsh/config.d"

# Tmux
link "$DOTFILES/.config/tmux/tmux.conf" "$CONFIG/tmux/tmux.conf"

# Neovim
link "$DOTFILES/.config/nvim" "$CONFIG/nvim"

# Lazygit
link "$DOTFILES/.config/lazygit/config.yml" "$CONFIG/lazygit/config.yml"

# Marimo
link "$DOTFILES/.config/marimo/marimo.toml" "$CONFIG/marimo/marimo.toml"

# Htop
link "$DOTFILES/.config/htop/htoprc" "$CONFIG/htop/htoprc"

# GH CLI
link "$DOTFILES/.config/gh/config.yml" "$CONFIG/gh/config.yml"

# ── Tmux Plugin Manager ───────────────────────────────────────────────────────
TPM_DIR="$CONFIG/tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

echo ""
echo "Done! Next steps:"
echo "  1. Run brew.sh to install packages"
echo "  2. Restart your terminal (or: source ~/.zshenv)"
echo "  3. In tmux, press <prefix> + I to install plugins"
