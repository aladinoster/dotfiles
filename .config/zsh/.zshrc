# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="/Users/andresladino/.oh-my-zsh"

# Theme configuration
# ZSH_THEME="powerlevel10k/powerlevel10k" # Uncomment to enable Powerlevel10k
ZSH_THEME="robbyrussell"

# Plugins
# Recommended: git, tmux, fzf, gh (github cli)
plugins=(git tmux fzf gh)

# Tmux Plugin Options (Must be set before sourcing OMZ)
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=true

# Init Oh My Zsh
source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8

# History
SAVEHIST=10000
HISTSIZE=10000
HISTFILE=${ZDOTDIR:-$HOME/.config/zsh}/.zsh_history
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Brew-installed plugins (zsh-autosuggestions, zsh-syntax-highlighting)
# These are sourced directly as they are often installed via Homebrew on macOS
[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/local/opt/zsh-git-prompt/zshrc.sh ] && source /usr/local/opt/zsh-git-prompt/zshrc.sh

# Powerlevel10k configuration
# To customize prompt, run `p10k configure` or edit .p10k.zsh.
[[ ! -f ${ZDOTDIR:-$HOME/.config/zsh}/.p10k.zsh ]] || source ${ZDOTDIR:-$HOME/.config/zsh}/.p10k.zsh

# --- Imported Configuration Style ---
# Load modular configurations from $ZDOTDIR/config.d
if [[ -d "$ZDOTDIR/config.d" ]]; then
  for config_file in "$ZDOTDIR/config.d/"*.zsh; do
    source "$config_file"
  done
fi