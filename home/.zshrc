HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt    append_history
setopt    share_history
setopt    inc_append_history

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

# neovim executable
export PATH="$HOME/.nvim/bin:$PATH"
alias vim=nvim

# default editor
export EDITOR=nvim

# Add Homebrew completions before compinit
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# enable completions
autoload -Uz compinit
compinit

# only when HEAD (SHA) changes
typeset -g LAST_GIT_SHA=""
typeset -g GIT_BRANCH=""

precmd() {
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local sha
    sha=$(git rev-parse --verify --short HEAD 2>/dev/null) || sha=""

    if [[ $sha != $LAST_GIT_SHA ]]; then
      LAST_GIT_SHA=$sha

      # compute branch; use symbolic-ref if available (clean branch name)
      GIT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --abbrev-ref HEAD 2>/dev/null || "")
      [[ $GIT_BRANCH == "HEAD" ]] && GIT_BRANCH=$sha
    fi
  else
    LAST_GIT_SHA=""
    GIT_BRANCH=""
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

# gpg
export GPG_TTY="$(tty)"

# local bin
export PATH="$PATH:$HOME/.local/bin"

# zig
# export PATH=$PATH:$HOME/Development/zig
# export PATH=$PATH:$HOME/Development/zls

# Gitignore generator
function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}

alias rm='rm -i'

# PATH analyzer
alias path-analyzer="echo $PATH | tr ':' '\n' | sort | uniq -c"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# FNM
eval "$(fnm env --use-on-cd --shell zsh)"
