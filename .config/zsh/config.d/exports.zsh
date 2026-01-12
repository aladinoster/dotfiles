# Editor
export EDITOR='nvim'

# Language Managers & Environments

# Rust
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init - zsh)"
fi

# Bun
export BUN_INSTALL="$HOME/.bun"
[ -d "$BUN_INSTALL/bin" ] && export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"