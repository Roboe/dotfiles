# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Differences between [ and [[: http://mywiki.wooledge.org/BashFAQ/031

# --------------- #
# TERMINAL COLORS #
# --------------- #

# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
  test -r ~/.dircolors && eval "$(dircolors --sh ~/.dircolors)" || eval "$(dircolors --sh)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias diff='diff --color=auto'
fi

# From ArchWiki: https://wiki.archlinux.org/index.php/Bash/Prompt_customization#Common_capabilities
function echolorize {
  local RST="$(tput sgr0)" # reset text
  case "$1" in
    "--title" ) local CLR="$(tput bold)$(tput smso)" && shift ;; # highlighted text
    "--danger") local CLR="$(tput setab 1)"          && shift ;; # red background
    "--advise") local CLR="$(tput setab 3)"          && shift ;; # yellow background
    *         ) local CLR="$(tput setab 4)"                   ;; # blue background (default)
  esac

  [[ "$#" != 0 ]] && echo -e "${CLR} $@ ${RST}"
}

# Emoji codepoints from the amazing http://www.fileformat.info
function emoji {
  local V16="\UFE0F" # Unicode variation 16. Forces emoji representation
  local NBSP="\U00A0" # Non-breaking space to fix V16 taking up no space

  case "$1" in
    "circular arrows") local CODEPOINTS="\U1F504"          ;;
    "community"      ) local CODEPOINTS="\U1F465"          ;;
    "cup"            ) local CODEPOINTS="\U2615"           ;;
    "download"       ) local CODEPOINTS="\U1F4E5"          ;;
    "package"        ) local CODEPOINTS="\U1F4E6"          ;;
    "tornado"        ) local CODEPOINTS="\U1F32A$V16$NBSP" ;;
    "traffic light"  ) local CODEPOINTS="\U1F6A6"          ;;
    "whirlpool"      ) local CODEPOINTS="\U1F300"          ;;
  esac

  echo -en "$CODEPOINTS"
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
    source /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion
  fi
fi
# case-insensitive completions
bind "set completion-ignore-case on"
# single tab completion
bind "set show-all-if-ambiguous on"
# git completion (Fedora)
if [[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]]; then
  source /usr/share/git-core/contrib/completion/git-prompt.sh
fi

# Change prompt
function change_prompt {
  # Wrapping the tput output in \[ \] is recommended by the Bash man page. This helps Bash ignore non printable characters so that it correctly calculates the size of the prompt.
  local RESET="\[$(tput sgr0)\]" # reset text attributes
  local BOLD="\[$(tput bold)\]" # bold text
  local GREEN="\[$(tput setaf 2)\]" # green text
  local BLUE="\[$(tput setaf 4)\]" # blue text

  PS1=""
  PS1+="┌─╼[$BOLD$BLUE\h$RESET]╾─╼[$GREEN\w$RESET]\$(__git_ps1) \n"
  PS1+="└╼ $BOLD\$$RESET "
}
change_prompt

# Change the terminal title bar to always display the current directory
#PROMPT_COMMAND='echo -ne "\e]0;$(pwd -P)\a"'


# ----------- #
# ENVIRONMENT #
# ----------- #

# Python 3 by default if available
## To use Python 2, use 'python2' instead
[[ $(which python3) ]] && alias python='python3'

# Python VirtualEnvWrapper setup
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
VIRTUALENVWRAPPER_INIT=/usr/local/bin/virtualenvwrapper.sh
[[ -r "$VIRTUALENVWRAPPER_INIT" ]] && source $VIRTUALENVWRAPPER

# Node Version Management setup
export N_PREFIX="/opt/node"
[[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

# Add Ruby user gems to PATH
export GEMS_DIR="$HOME/.gem"
[[ -r "$GEMS_DIR" ]] && export PATH="$PATH:$(ls -td -- $GEMS_DIR/ruby/*/ | head -n 1)bin"

# Java setup
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/

# Android setup
ANDROID_PREFIX="/opt/android"
export ANDROID_SDK_ROOT="$ANDROID_PREFIX/sdk-linux"
export ANDROID_NDK_PATH="$ANDROID_SDK_ROOT/ndk-bundle"
export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"


# --------------------- #
# ALIASES AND FUNCTIONS #
# --------------------- #

# Add aliases and functions
#[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# Terminal navigation
## Shorter 'ls'
alias ll='ls --all --format=long --classify'
alias la='ls --classify'
alias l='ls --format=vertical --classify'

## Suspenseful 'cd' (pun intended)
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

## Quick 'mkdir' and 'cd' to new folder
function mkd {
  mkdir --parents "$@" && cd "$@"
}

## Search for some text in the current folder
alias search='grep --recursive --line-number --word-regexp -e'

## Print file size
alias filesize='du --human-readable'

## List terminal jobs or kill last one
alias jobs='jobs -l'
alias jkill='kill $!'

## Local IP addresses
alias localip='hostname --all-ip-addresses'

## Add an "alert" alias for long running commands. Use like so:
##   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([[ $? = 0 ]] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

## Quick exit clearing history
alias x='history -cw && exit'


# Static servers
## HTTP server. From this superuseful Gist: https://gist.github.com/willurd/5720255
[[ $(which python2) ]] && alias serve2='echo "Serving on http://localhost:8000/" && python2 -m SimpleHTTPServer 8000'
[[ $(which python3) ]] && alias serve3='echo "Serving on http://localhost:8000/" && python3 -m http.server 8000'

## FTP server. Prerequisite: 'python-pyftpdlib' or 'python3-pyftpdlib' package
[[ $(which python2) ]] && alias ftpserve2='echo "Serving on http://localhost:2121/" && python2 -m pyftpdlib'
[[ $(which python3) ]] && alias ftpserve3='echo "Serving on http://localhost:2121/" && python3 -m pyftpdlib'

if [[ $(which python2) ]]; then # Prefer python2 server
  alias serve='serve2'
  alias ftpserve='ftpserve2'
elif [[ $(which python3) ]]; then # Fallback to python3 server
  alias serve='serve3'
  alias ftpserve='ftpserve3'
fi


## Update git fork from upstream
function guf {
  git checkout master
  git pull upstream master
  git push origin master
}

## Wait until network is reachable before continuing
function wait-for-network {
  local DESTINATION=${1:-1.1.1.1}
  local INTERVAL=${2:-0.1}

  while ! ping -q -c1 $DESTINATION &>/dev/null
  do sleep $INTERVAL
  done
}


# System maintenance
## Disks relation
alias disk='df --human-readable | grep -e /dev/sd -e Filesystem' # Show disk information

## Restart NetworkManager service
alias renm='sudo systemctl restart NetworkManager'

## Configure the default Java version
function choosejava {
  sudo update-alternatives --config java
  sudo update-alternatives --config javac
  echolorize --title "$(emoji "cup") Java interpreter version"
  java -version
  echolorize --title "$(emoji "traffic light") Java compiler version"
  javac -version
}


## Dim the screen brightness level, mainly for CLI terminals
## Pass a percentage as the only parameter
function dim {
  if [[ $1 -lt 1 ]]; then
    echo "Turning off your screen is dangerous because the change persist after reboots"
    return
  fi

  MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness)
  DESIRED_BRIGHTNESS=$(expr ${1} * ${MAX_BRIGHTNESS} / 100)
  echo $DESIRED_BRIGHTNESS | sudo tee /sys/class/backlight/intel_backlight/brightness
}

## Check the battery status and charge
alias bat='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|to\ full|percentage"'


## System update and cleanup for multiple GNU/Linux distros
alias upper='up --per'
function up {
  wait-for-network

  if [[ $(which apt) ]]; then
    echolorize --title "$(emoji "package") APT"
    apt-up $@
  fi

  if [[ $(which dnf) ]]; then
    echolorize --title "$(emoji "package") DNF"
    dnf-up $@
  fi

  if [[ $(which pacman) ]]; then
    echolorize --title "$(emoji "package") PACMAN"
    pacman-up $@
  fi

  if [[ $(which flatpak) ]]; then
    echolorize --title "$(emoji "package") FLATPAK"
    flatpak-up $@
  fi
}

## System update and cleanup for Debian/Ubuntu
function apt-up {
  echolorize "$(emoji "circular arrows") UPDATE"
  sudo apt update --quiet

  if [[ "$#" != 0 && "$1" == "--per" ]]; then
    echolorize --danger "$(emoji "download") FULL-UPGRADE"
    sudo apt full-upgrade
  else
    echolorize "$(emoji "download") UPGRADE"
    sudo apt upgrade --assume-yes
  fi

  echolorize --advise "$(emoji "whirlpool") AUTOREMOVE --PURGE"
  sudo apt autoremove --purge --assume-yes

  echolorize "$(emoji "tornado") AUTOCLEAN"
  sudo apt autoclean
}

## System update and cleanup for Fedora
function dnf-up {
  echolorize "$(emoji "circular arrows") CHECK-UPDATE"
  sudo dnf check-update

  echolorize "$(emoji "download") UPGRADE"
  sudo dnf upgrade

  echolorize --advise "$(emoji "whirlpool") AUTOREMOVE"
  sudo dnf autoremove

  echolorize "$(emoji "tornado") CLEAN"
  sudo dnf clean all
}

## System update and cleanup for Arch/Parabola
function pacman-up {
  if [[ $(which yaourt) ]]; then
    echolorize "$(emoji "community") SYNC UPDATES FROM AUR"
    yaourt --sync --refresh --upgrades --aur
  else
    echolorize "$(emoji "download") SYNC UPDATES"
    pacman --sync --refresh --upgrades
  fi

  echolorize "$(emoji "whirlpool") REMOVE ORPHANS"
  sudo pacman --remove --native --search $(pacman --query --quiet --nodeps --unrequired)
}


## Update and cleanup flatpak packages
function flatpak-up {
  echolorize "$(emoji "circular arrows") UPDATE"
  flatpak --user update --assumeyes
  echolorize "$(emoji "whirlpool") UNINSTALL UNUSED"
  flatpak --user uninstall --unused --assumeyes
}

## Completely remove flatpak packages and data
alias flatpak-rm="flatpak --user uninstall --delete-data"

## Install local package with Gnome Software
[[ $(which gnome-software) ]] && function software-install {
  gnome-software --local-filename="$1"
}

## Alias to query why a package was autoinstalled
alias apt-why='apt rdepends --no-{suggests,conflicts,breaks,replaces,enhances} --installed --recurse'


# ---------------- #
# GRAPHICAL OUTPUT #
# ---------------- #

# Show distro and screen info
[[ $(which screenfetch) ]] && screenfetch
