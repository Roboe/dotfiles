# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Differences between [ and [[: http://mywiki.wooledge.org/BashFAQ/031

# --------------- #
# TERMINAL COLORS #
# --------------- #

# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# From Archwiki: https://wiki.archlinux.org/index.php/Color_Bash_Prompt
HC="\[\033[1m\]"    # hicolor
FRS="\[\033[0m\]"   # foreground reset
FRED="\[\033[31m\]" # red foreground
FGRN="\[\033[32m\]" # green foreground
FBLE="\[\033[33m\]" # yellow foreground
FBLE="\[\033[34m\]" # blue foreground

BRS="\e[0m"   # background reset
BRED="\e[41m" # red background
BGRN="\e[42m" # green background
BYLW="\e[43m" # yellow background
BBLE="\e[44m" # blue background

function echolorize {
  endclz=$BRS # Reset color
  case "$1" in
  "--danger") clz=$BRED && shift ;; # red bg
  "--advise") clz=$BYLW && shift ;; # yellow bg
  *) clz=$BBLE ;; # blue bg (default)
  esac

  [[ "$#" != 0 ]] && echo -e "${clz}# $1 ${endclz}"
}


# ----------------- #
# SESSION SETTINGS  #
# ----------------- #

# Set 'nano' as the default editor
export EDITOR=nano

# Disable .bash_history
unset HISTFILE

# enable programmable completion features (you don't need to enable
# this if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
  fi
fi

# Change prompt
PS1=""
PS1+="┌─╼[$HC$FBLE\h$FRS]╾─╼[$FGRN\w$FRS]\$(__git_ps1) \n"
PS1+="└╼ $HC\$ $FRS"

# Change the terminal title bar to always display the current directory
#PROMPT_COMMAND='echo -ne "\e]0;$(pwd -P)\a"'


# ----------- #
# ENVIRONMENT #
# ----------- #

# Python 3 by default if available
## To use Python 2, use 'python2' instead
[[ $(which python3) ]] && alias python='python3'

# Java setup
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

# Python VirtualEnvWrapper setup
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

# Node Version Manager setup
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Ruby enVironment Manager setup
#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Add Android SDK to PATH
PATH="$PATH:/opt/android-sdk-linux/platform-tools"

# Add Android Studio to PATH
PATH="$PATH:/opt/android-studio/bin"


# --------------------- #
# ALIASES AND FUNCTIONS #
# --------------------- #

# Add aliases and functions
#[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# Terminal navigation
## Shorter 'ls'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

## Suspenseful 'cd' (pun intended)
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

## Quick 'mkdir' and 'cd' to new folder
function mkd {
  mkdir -p "$@" && cd "$@"
}

## List terminal jobs or kill last one
alias jobs='jobs -l'
alias jkill='kill $!'

## Add an "alert" alias for long running commands. Use like so:
##   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([[ $? = 0 ]] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

## Quick exit clearing history
alias x='history -cw && exit'


# Static servers
## From this superuseful Gist: https://gist.github.com/willurd/5720255
[[ $(which python2) ]] && alias serve2='echo "Serving on http://localhost:8000/" && python2 -m SimpleHTTPServer 8000'
[[ $(which python3) ]] && alias serve3='echo "Serving on http://localhost:8000/" && python3 -m http.server 8000'

if [[ $(which python2) ]]; then # Prefer python2 server
  alias serve='serve2'
elif [[ $(which python3) ]]; then # Fallback to python3 server
  alias serve='serve3'
fi


# Git shortcuts
#alias gl='git log --graph --full-history --all --color --pretty=tformat:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s%x20%x1b[33m(%an)%x1b[0m"'
alias gl='git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all' # From http://stackoverflow.com/a/9074343

alias gs="git status"
alias gb="git branch"
alias gd="git diff"

## Remove local branches already deleted from remote. Use like so:
##   gprune <remote>
alias gprune="git remote prune"

## Update fork from upstream
function guf {
  git checkout master
  git pull upstream master
  git push origin master
}


# System maintenance
## Disks relation
alias disk='df -h | grep -e /dev/sd -e Filesystem' # Show disk information

## Restart NetworkManager service
alias renm='sudo systemctl restart NetworkManager'

## System update and cleanup for Arch/Parabola
function pac-up {
  yaourt -Syua
  sudo pacman -Rns $(pacman -Qqdt)
}

## System update and cleanup for Debian/Ubuntu
alias upper='up --per'
function up {
  echolorize "UPDATE"
  sudo apt-get update -qq # Show only errors on update

  echolorize "UPGRADE"
  sudo apt-get upgrade -y

  if [[ "$#" != 0 && "$1" == "--per" ]]; then
    echolorize --danger "DIST-UPGRADE"
    sudo apt-get dist-upgrade
  fi

  echolorize --advise "AUTOREMOVE --PURGE"
  sudo apt-get autoremove --purge -y

  echolorize "AUTOCLEAN"
  sudo apt-get autoclean
}


# ---------------- #
# GRAPHICAL OUTPUT #
# ---------------- #

# Show distro and screen info
[[ $(which screenfetch) ]] && screenfetch
