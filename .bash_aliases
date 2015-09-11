# -------------------- #
# DIRECTORY NAVIGATION #
# -------------------- #

# ls made shorter
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# cd made suspenseful (pun intended)
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Create dir and change to it
function mkd {
  mkdir -p "$@" && cd "$@"
}


# ----------------------------- #
# DEFAULTS AND TERMINAL-RELATED #
# ----------------------------- #

# List terminal jobs or kill last one
alias jobs='jobs -l'
alias jkill='kill $!'

# Exit clearing history
alias x='history -cw && exit'

# Static server
## From this superuseful Gist: https://gist.github.com/willurd/5720255
alias serve='serve2'
alias serve2='echo "Go to http://localhost:8000/"; python2 -m SimpleHTTPServer 8000'
alias serve3='echo "Go to http://localhost:8000/"; python3 -m http.server 8000'

# Highlight some important headers
function echolorize {
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


# ------------- #
# GIT SHORTCUTS #
# ------------- #

alias gl='git log --graph --full-history --all --color --pretty=tformat:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s%x20%x1b[33m(%an)%x1b[0m"'

alias gs="git status"
alias gb="git branch"
alias gd="git diff"

# Remove local branches already deleted from remote. Use like so:
#   gprune <remote>
alias gprune="git remote prune"

# Update fork from upstream
function guf {
  git checkout master
  git pull upstream master
  git push origin master
}

# Recursive fetch/pull
alias grf='grec fetch'
alias grp='grec pull'
function grec {
  for file in ./*; do
    cd $file
    if [ -d .git ]; then
      echolorize $(pwd)
      git $1
    fi
    cd ..
  done
}


# ------------------ #
# SYSTEM MAINTENANCE #
# ------------------ #

# Disks relation
alias disk='df -h | grep -e /dev/sd -e Filesystem' # Show disk information

# Restart NetworkManager service
alias renm='sudo systemctl restart NetworkManager'

# System update and cleanup for Arch/Parabola
function pac-up {
  yaourt -Syua
  sudo pacman -Rns $(pacman -Qqdt)
}

# System update and cleanup for Debian/Ubuntu
alias upper='up --per'
function up {
  # Update repos showing only errors
  echolorize "UPDATE"
  sudo apt-get update -qq

  # Upgrade packages
  echolorize "UPGRADE"
  sudo apt-get upgrade -y

  # Upgrade sensitive packages, like kernel
  if [ "$#" != 0 ] && [ "$1" == "--per" ]; then
    echolorize --danger "DIST-UPGRADE"
    sudo apt-get dist-upgrade
  fi

  # Remove unused dependencies and its data
  echolorize --advise "AUTOREMOVE --PURGE"
  sudo apt-get autoremove --purge -y

  # Remove non-needed, cached packages
  echolorize "AUTOCLEAN"
  sudo apt-get autoclean
}
