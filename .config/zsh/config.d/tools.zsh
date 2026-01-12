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

