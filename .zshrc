#==========================================================
# OH MY ZSH CONFIG
#==========================================================

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="bira"

plugins=(
    git
    command-not-found
)

source $ZSH/oh-my-zsh.sh

#==========================================================
# PATH SETUP
#==========================================================

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


#==========================================================
# OTHER CONFIGS SETUP
#==========================================================

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# use fd instead of fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - the first argument to the function ($1) is the base path to start traversal
# - see the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/.fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# advanced customization of fzf options via _fzf_comprun function
# - the first argument to the function is the name of the command.
# - you should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# bat - better cat
file_to_preview_with_bat=~/work/it-cat/website/skynet/skynet-service/src/main/java/com/cloudera/skynet/api/v20/service/coveo/MSCoveoService.java
alias bat-themes-preview='bat --list-themes | fzf --preview="bat --theme={} --color=always $file_to_preview_with_bat"'

export BAT_THEME="TwoDark"

# eza - better ls
alias ls="eza --icons=always"

# zoxide - better cd  
eval "$(zoxide init zsh)"

alias cd="z"

# thefuck
eval $(thefuck --alias)
eval $(thefuck --alias fk)

#==========================================================
# ALIASES
#==========================================================

# terminal
alias cl="clear"
alias cp="cp -i"
alias more="less"
alias grep="grep -i --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"
alias reload="source ~/.zshrc"

# config files
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="vim ~/.zshrc"
alias edit-vim="vim ~/.vimrc"

# git
alias gI='git init'
alias gA="git add ."
alias gP="git push origin master"
alias gL="git pull origin master"
alias gC="gcmsg"
alias gS="git status"
alias glog="git log --oneline --all --graph --decorate"
alias gitu="git add . && git commit && git push"

# docker
alias diL="docker images"
alias dvL="docker volume ls"
alias dnL="docker network ls"
alias dR="docker run --rm"
alias dS="docker stop"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias drm="docker rm"
alias drmi="docker rmi"
drma() { docker rm $(docker ps -aq ) }
