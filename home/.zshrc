HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt    append_history
setopt    share_history
setopt    inc_append_history

# Make ls use colors
export CLICOLOR=1
alias ls='ls -Fa'

# Define colors
C_DEFAULT='%f%k'
C_WHITE='%F{white}'
C_GRAY='%F{244}'
C_BLACK='%F{black}'
C_RED='%F{red}'
C_GREEN='%F{green}'
C_YELLOW='%F{yellow}'
C_BLUE='%F{blue}'
C_PURPLE='%F{magenta}'
C_CYAN='%F{cyan}'
C_LIGHTGRAY='%F{white}'
C_DARKGRAY='%F{black}'
C_LIGHTRED='%F{red}'
C_LIGHTGREEN='%F{green}'
C_LIGHTYELLOW='%F{yellow}'
C_LIGHTBLUE='%F{blue}'
C_LIGHTPURPLE='%F{magenta}'
C_LIGHTCYAN='%F{cyan}'
C_BG_BLACK='%K{black}'
C_BG_RED='%K{red}'
C_BG_GREEN='%K{green}'
C_BG_YELLOW='%K{yellow}'
C_BG_BLUE='%K{blue}'
C_BG_PURPLE='%K{magenta}'
C_BG_CYAN='%K{cyan}'
C_BG_LIGHTGRAY='%K{white}'

# Cache last directory and branch
typeset -g LAST_PWD=""
typeset -g GIT_BRANCH=""

# Update branch only when directory changes
precmd() {
  if [[ $PWD != $LAST_PWD ]]; then
    LAST_PWD=$PWD
    GIT_BRANCH=""

    # Only attempt to get branch if this is a git repo we can read
    if [[ -d .git || $(git rev-parse --git-dir 2>/dev/null) ]]; then
      GIT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || "")
    fi
  fi
}

# Display branch in gray, only if it exists, and not bold
git_prompt() {
  [[ -n $GIT_BRANCH ]] && echo " %b${C_GRAY}[${GIT_BRANCH}]"
}

# Set prompt
setopt prompt_subst
PROMPT='%B${C_LIGHTGREEN}%n%b${C_DEFAULT}@${C_BLUE}%m%B${C_LIGHTYELLOW} %1~$(git_prompt)%b${C_DEFAULT} %# '

# rbenv
# if command -v rbenv >/dev/null; then
#   eval "$(rbenv init -)"
# fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
# eval "$(pyenv virtualenv-init -)"

# Lazy-load NVM
source ~/.nvm_lazyload.zsh

# gpg
export GPG_TTY="$(tty)"

# local bin
export PATH="$PATH:$HOME/.local/bin"

# zig
# export PATH=$PATH:$HOME/Development/zig
# export PATH=$PATH:$HOME/Development/zls

# neovim executable
export PATH="$HOME/.nvim/bin:$PATH"
alias vim=nvim

# Gitignore generator
function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}

alias rm='rm -i'

# PATH analyzer
alias path-analyzer="echo $PATH | tr ':' '\n' | sort | uniq -c"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
