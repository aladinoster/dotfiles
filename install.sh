#!/usr/bin/env bash
# Dotfiles installation script — run once on a new machine
# Usage: chmod +x install.sh && ./install.sh

set -e

DOTFILES="$HOME/dotfiles"

echo "Installing dotfiles from $DOTFILES..."

# ── Submodules ────────────────────────────────────────────────────────────────
echo "Initializing submodules..."
git -C "$DOTFILES" submodule update --init --recursive

# ── Home dotfiles ─────────────────────────────────────────────────────────────
ln -sf "$DOTFILES/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/.aliases" "$HOME/.aliases"
echo "Linked: ~/.zshenv, ~/.aliases"

# ── ~/.config symlink ─────────────────────────────────────────────────────────
if [ -L "$HOME/.config" ]; then
  echo "~/.config is already a symlink, skipping."
elif [ -d "$HOME/.config" ]; then
  echo "Backing up ~/.config → ~/.config.bak"
  mv "$HOME/.config" "$HOME/.config.bak"
  ln -sf "$DOTFILES/.config" "$HOME/.config"
  echo "Linked: ~/.config → $DOTFILES/.config"
else
  ln -sf "$DOTFILES/.config" "$HOME/.config"
  echo "Linked: ~/.config → $DOTFILES/.config"
fi

# ── Tmux Plugin Manager ───────────────────────────────────────────────────────
TPM_DIR="$HOME/.config/tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

echo ""
echo "Done! Next steps:"
echo "  1. Run brew.sh to install packages"
echo "  2. Restart your terminal (or: source ~/.zshenv)"
echo "  3. In tmux, press <prefix> + I to install plugins"
