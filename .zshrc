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
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # this loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # this loads nvm bash_completion

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
export BAT_THEME="TwoDark"
alias cat="bat"

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

alias cp="cp -i"
alias grep="grep -i --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"

alias reload_zsh="source ~/.zshrc"
alias edit_zsh="vim ~/.zshrc"
alias edit_vim="vim ~/.vimrc"

alias list_aliases='alias | fzf --preview "echo {} | cut -d'=' -f1 | xargs -I % sh -c '\''alias %'\'' | bat --style=plain"'
alias list_env='env | cut -d= -f1 | fzf --preview "echo {}=\$(printenv {})"'
alias list_bat_themes='bat --list-themes | fzf --preview="bat --theme={} --color=always ~/.zshrc"'
