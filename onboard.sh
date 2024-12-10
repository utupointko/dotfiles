#!/bin/sh

# exit script immediately on error
set -e

function install_raycast() {
    echo "> installing raycast..."

    brew install -q --cask raycast || {
        echo "error: failed to install raycast"
        exit 1
    }
}

function install_dependencies() {
    echo "> installing dependencies..."
    
    # install fonts
    brew install -q --cask font-meslo-lg-nerd-font || {
        echo "error: failed to install fonts"
        exit 1
    }

    # install wezterm
    brew install -q --cask wezterm || {
        echo "error: failed to install wezterm"
        exit 1
    }
    
    # install oh my zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || {
            echo "error: failed to install oh my zsh"
            exit 1
        }
    fi
    
    # install zsh plugins
    brew install -q zsh-autosuggestions zsh-syntax-highlighting || {
        echo "error: failed to install zsh plugins"
        exit 1
    }

    # install nvim
    brew install -q nvim && git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim && rm -rf ~/.config/nvim/.git || {
        echo "error: failed to install nvim"
        exit 1
    }
    
    # install additional tools
    brew install -q fzf fd git-delta bat eza zoxide tldr thefuck || {
        echo "error: failed to install additional tools"
        exit 1
    }
    rm -rf ~/.fzf-git.sh && git clone -q https://github.com/junegunn/fzf-git.sh.git ~/.fzf-git.sh || {
        echo "error: failed to clone junegunn/fzf-git.sh.git repository"
        exit 1
    }

    brew install -q --cask karabiner-elements || {
        echo "error: failed to install fonts"
        exit 1
    }
}

function copy_dotfiles() {
    echo "> copying dotfiles..."

    # coping wezterm files
    cp .wezterm.lua ~/.wezterm.lua || {
        echo "error: failed to copy .wezterm.lua"
        exit 1
    }

    # coping zsh files
    cp .zshrc ~/.zshrc || {
        echo "error: failed to copy .zshrc"
        exit 1
    }
}

function set_gitconfig() {
    echo "> setting gitconfig..."

    cat .gitconfig >> ~/.gitconfig || {
        echo "error: failed to set gitconfig"
        exit 1
    }
}

function reload_configs() {
    echo "> reloading configs..."

    zsh -c 'source ~/.zshrc' || {
        echo "error: failed to reload configs"
        exit 1
    }
}

function start_setup() {
    # uncomment the functions you want to run
    install_raycast
    install_dependencies
    copy_dotfiles
    set_gitconfig
    reload_configs
}

start_setup

echo "> done ✔️"
