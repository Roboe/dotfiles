# ------------------------------- #
# SELECTED DEFAULT CONFIGURATIONS #
# ------------------------------- #

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# --------------- #
# CUSTOMIZATIONS  #
# --------------- #

# Set 'nano' as the default editor
export EDITOR=nano

# Disable .bash_history
unset HISTFILE

# Python 3 by default
## To use Python 2, use python2 and pip2 instead
alias python='python3'
alias pip='sudo -H pip3'

# VirtualEnvWrapper setup
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

# Colors
RS="\[\033[0m\]"    # reset
HC="\[\033[1m\]"    # hicolor
FRED="\[\033[31m\]" # foreground red
FGRN="\[\033[32m\]" # foreground green
FBLE="\[\033[34m\]" # foreground blue

# Change prompt
PS1=""
PS1+="┌─╼[$HC$FBLE\h$RS]╾─╼[$FGRN\w$RS]\$(__git_ps1) \n"
PS1+="└╼ $HC\$ $RS"

# Change the terminal title bar to always display the current directory
#PROMPT_COMMAND='echo -ne "\e]0;$(pwd -P)\a"'

# Add aliases and functions
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

# Show distro and screen info
if [ -d ~/bin ]; then
  screenfetch
fi
