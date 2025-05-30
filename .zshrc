HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt    append_history
setopt    share_history
setopt    inc_append_history

# Make ls use colors
export CLICOLOR=1
alias ls='ls -Fa'

# define colors
C_DEFAULT=$'%{\e[m%}'
C_WHITE=$'%{\e[1m%}'
C_BLACK=$'%{\e[30m%}'
C_RED=$'%{\e[31m%}'
C_GREEN=$'%{\e[32m%}'
C_YELLOW=$'%{\e[33m%}'
C_BLUE=$'%{\e[34m%}'
C_PURPLE=$'%{\e[35m%}'
C_CYAN=$'%{\e[36m%}'
C_LIGHTGRAY=$'%{\e[37m%}'
C_DARKGRAY=$'%{\e[1;30m%}'
C_LIGHTRED=$'%{\e[1;31m%}'
C_LIGHTGREEN=$'%{\e[1;32m%}'
C_LIGHTYELLOW=$'%{\e[1;33m%}'
C_LIGHTBLUE=$'%{\e[1;34m%}'
C_LIGHTPURPLE=$'%{\e[1;35m%}'
C_LIGHTCYAN=$'%{\e[1;36m%}'
C_BG_BLACK=$'%{\e[40m%}'
C_BG_RED=$'%{\e[41m%}'
C_BG_GREEN=$'%{\e[42m%}'
C_BG_YELLOW=$'%{\e[43m%}'
C_BG_BLUE=$'%{\e[44m%}'
C_BG_PURPLE=$'%{\e[45m%}'
C_BG_CYAN=$'%{\e[46m%}'
C_BG_LIGHTGRAY=$'%{\e[47m%}'

# set your prompt
export PS1="$C_LIGHTGREEN%n$C_DEFAULT@$C_BLUE%m$C_LIGHTYELLOW %1~ $C_DEFAULT%# "

# rbenv
# eval "$(rbenv init -)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
# eval "$(pyenv virtualenv-init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# gpg
export GPG_TTY="$(tty)"

# local bin
export PATH=$PATH:$HOME/.local/bin

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

# Dotfiles management script
alias dotfiles='$HOME/.dotfiles/scripts/dotfiles-manager.sh'

