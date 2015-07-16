# ------------------------------- #
# SELECTED DEFAULT CONFIGURATIONS #
# ------------------------------- #

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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


# ---------------------- #
#  ROBOE CUSTOMIZATIONS  #
# ---------------------- #

# Set 'nano' as the default editor
export EDITOR=nano

# Colors
RS="\[\033[0m\]"    # reset
HC="\[\033[1m\]"    # hicolor
FRED="\[\033[31m\]" # foreground red
FGRN="\[\033[32m\]" # foreground green
FBLE="\[\033[34m\]" # foreground blue

# Change prompt
## 'user in ~/foo/bar \n $'
#PS1='┌─╼[\[\e[1;34m\]\h\[\e[0;37m\]]╾─╼[\[\e[1;37m\]\w\[\e[0;37m\]]$(__git_ps1) \n└─╼\[\e[1;34m\]\$ \[\e[m\]'
## '┌─╼[user]]╾─╼[~/foo/bar] (branch) \n └╼ $'
PS1="┌─╼[$HC$FBLE\h$RS]╾─╼[$FGRN\w$RS]$(__git_ps1) \n└╼ $HC\$ $RS"

# Change the terminal title bar to always display the current directory
#PROMPT_COMMAND='echo -ne "\e]0;$(pwd -P)\a"'

# Show distro and screen info
if [ -d ~/bin ]; then
	screenfetch
fi


# --------------------- #
# ALIASES AND FUNCTIONS #
# --------------------- #

# System updating and cleanup for Arch Linux
#alias packages-update='yaourt -Syua && sudo pacman -Rns $(pacman -Qqdt)'

# Dir thingies
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Mkdir and cd to the dir
#alias mkd='mkdir -p "$@" && eval cd "\"\$$#\""'

# Disks relation
alias disk='df -h | grep -e /dev/sd -e Filesystem' # Show disk information

# Static server, from this superuseful Gist https://gist.github.com/willurd/5720255
alias serve='echo "Serving on http://0.0.0.0:8000/"; python -m SimpleHTTPServer 8000 &'

# Terminal jobs
alias jobs='jobs -l'
alias jkill='kill $!'

# **Strongly personal custom aliases**. You have been warned.
alias subgit='git submodule'
alias x='history -cw && exit' # Exit clearing history
alias tree='find . -type d -print | sed -e "s;[^/]*/;|____;g;s;____|; |;g"' # Tree ls

# Applications WIP
alias ff='firefox > /dev/null &'


# --------- #
# FUNCTIONS #
# --------- #
function mkd() {
	mkdir -p "$@" && cd "$@"
}

function echolorize() {
    # Archwiki: https://wiki.archlinux.org/index.php/Color_Bash_Prompt
    clz="\e[44m" # Blue background
    endclz="\e[0m" # No background color
 
    if [ "$#" != 0 ]; then
        if [ "$#" -eq 2 ]; then
            case "$1" in
            "--danger")
                clz="\e[41m" # Red background
                ;;
            "--advise")
                clz="\e[43m" # Yellow background
                ;;
            *)
                ;;
            esac
            shift # $2 becomes $1
        fi
        echo -e "${clz}# $1 ${endclz}"
    fi
}

function up() {
	echolorize "UPDATE"
	sudo apt-get update -qq;
	 
	echolorize "UPGRADE"
	sudo apt-get upgrade -y;
	 
	if [ "$#" != 0 ] && [ "$1" == "--per" ]; then
		echolorize --danger "DIST-UPGRADE"
		sudo apt-get dist-upgrade;
	fi
	 
	echolorize -advise "AUTOREMOVE --PURGE"
	sudo apt-get autoremove --purge -y;
	 
	echolorize "AUTOCLEAN"
	sudo apt-get autoclean;
}

alias upper='up --per'


# ------------ #
# TEMP ALIASES #
# ------------ #

alias film='cd ~/h4/filmviz/'
