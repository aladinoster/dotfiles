# Dotfiles

Configuration files for macOS, following the XDG Base Directory specification.

## Prerequisites

1.  Install [Homebrew](https://brew.sh/).
2.  Install [Oh My Zsh](https://ohmyz.sh/).

## Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/aladinoster/dotfiles.git ~/dotfiles
    cd ~/dotfiles
    ```

2.  **Install dependencies:**

    ```bash
    chmod +x brew.sh
    ./brew.sh
    ```

3.  **Link Configurations:**

    Ensure `~/.config` exists:
    ```bash
    mkdir -p ~/.config
    ```

    Create symbolic links for the configurations:
    ```bash
    # Zsh
    ln -sf ~/dotfiles/.zshenv ~/.zshenv
    ln -sf ~/dotfiles/.config/zsh ~/.config/zsh

    # Tmux
    ln -sf ~/dotfiles/.config/tmux ~/.config/tmux

    # Git
    ln -sf ~/dotfiles/.config/git ~/.config/git
    ```

4.  **Finalize:**
    Restart your terminal. tmux should auto-start, and zsh will load from `.config/zsh/.zshrc`.