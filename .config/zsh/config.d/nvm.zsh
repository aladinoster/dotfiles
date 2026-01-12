# NVM Configuration
export NVM_DIR="$HOME/.nvm"

# Load NVM
if [ -s "$NVM_DIR/nvm.sh" ]; then
  source "$NVM_DIR/nvm.sh"
elif [ -s "/usr/local/opt/nvm/nvm.sh" ]; then
  source "/usr/local/opt/nvm/nvm.sh"
fi

# Load NVM Completion
if [ -s "$NVM_DIR/bash_completion" ]; then
  source "$NVM_DIR/bash_completion"
elif [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ]; then
  source "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
fi
