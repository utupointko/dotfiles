#!/bin/sh

function install_raycast() {
    brew uninstall --cask raycast
    # config load

    echo "> installed raycast"
}

function install_dependencies() {
    brew install --cask wezterm
    brew tap homebrew/cask-fonts
    brew install homebrew/cask/font-meslo-lg-nerd-font
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    brew install zsh-autosuggestions
    brew install zsh-syntax-highlighting
    brew install fzf
    brew install fd
    git clone https://github.com/junegunn/fzf-git.sh.git ~/.fzf-git.sh
    brew install git-delta
    brew install bat
    brew install eza
    brew install zoxide
    brew install tldr
    brew install thefuck


    echo "> installed dependencies"
}

function copy_dotfiles() {
    cp .wezterm.lua ~/
    cp .zshrc ~/
    
    echo "> copied dotfiles"
}

function set_gitconfig() {
    cat .gitconfig >> ~/.gitconfig

    echo "> set gitconfig"
}

function reload_configs() {
    zsh -c 'source ~/.zshrc && echo "> reloaded configs"'
}

# install_raycast
# install_dependencies
# set_gitconfig
copy_dotfiles
reload_configs
