# General Aliases
alias nv="nvim"

# Fzf Configuration & Aliases
# source <(fzf --zsh) # (Commented out in original)
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # (Commented out in original)

alias fnvim="nvim \$(fzf --preview 'cat {}' --height 40%)"
export FZF_DEFAULT_OPTS="--color=fg:#ffffff,bg:#1e1e1e,hl:#dcdcaa,fg+:#dcdcaa,bg+:#333333,hl+:#dcdcaa $FZF_DEFAULT_OPTS"
export FZF_DEFAULT_OPTS="--preview 'glow --style=dark {}' --preview-window=right:50%"

# Functions
# Find and change to a selected directory
fcd() {
  local dir
  dir=$(find "${1:-.}" -type d -print 2> /dev/null | fzf)
  if [[ -d "$dir" ]]; then
    cd "$dir"
  fi
}

# ── Dotfiles helpers ──────────────────────────────────────────────────────────

# Push nvim changes to config.nvim AND bump the submodule pointer in dotfiles
# Usage: nvim-push "optional commit message"
nvim-push() {
  local msg="${1:-update nvim config}"
  echo "→ Pushing nvim (config.nvim)..."
  git -C "$HOME/.config/nvim" add -A \
    && git -C "$HOME/.config/nvim" commit -m "$msg" \
    && git -C "$HOME/.config/nvim" push \
    || echo "  (nothing to commit or push failed)"
  echo "→ Bumping submodule pointer in dotfiles..."
  git -C "$HOME/dotfiles" add .config/nvim
  if git -C "$HOME/dotfiles" diff --cached --quiet; then
    echo "  Pointer already up to date."
  else
    git -C "$HOME/dotfiles" commit -m "chore: bump nvim submodule" \
      && git -C "$HOME/dotfiles" push
  fi
}

