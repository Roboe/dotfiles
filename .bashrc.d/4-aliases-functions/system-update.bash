# System update and cleanup for multiple GNU/Linux distros
alias upper='up --per'
function up {
  wait-for-network

  if [[ $(which apt) ]]
  then
    echolorize --title "$(emoji "package") APT"
    apt-up "$@"
  fi

  if [[ $(which dnf) ]]
  then
    echolorize --title "$(emoji "package") DNF"
    dnf-up "$@"
  fi

  if [[ $(which pacman) ]]
  then
    echolorize --title "$(emoji "package") PACMAN"
    pacman-up "$@"
  fi

  if [[ $(which flatpak) ]]
  then
    echolorize --title "$(emoji "package") FLATPAK"
    flatpak-up "$@"
  fi
}


## Debian/Ubuntu
function apt-up {
  echolorize "$(emoji "circular arrows") UPDATE"
  sudo apt update --quiet

  if [[ "$#" != 0 && "$1" == "--per" ]]
  then
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


## Fedora
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


## Arch/Parabola
function pacman-up {
  if [[ $(which yaourt) ]]
  then
    echolorize "$(emoji "community") SYNC UPDATES FROM AUR"
    yaourt --sync --refresh --upgrades --aur
  else
    echolorize "$(emoji "download") SYNC UPDATES"
    pacman --sync --refresh --upgrades
  fi

  echolorize "$(emoji "whirlpool") REMOVE ORPHANS"
  sudo pacman --remove --native --search "$(pacman --query --quiet --nodeps --unrequired)"
}


## Flatpak packages
function flatpak-up {
  echolorize "$(emoji "circular arrows") UPDATE"
  flatpak --user update --assumeyes
  echolorize "$(emoji "whirlpool") UNINSTALL UNUSED"
  flatpak --user uninstall --unused --assumeyes
}

## Completely remove flatpak packages and data
alias flatpak-rm="flatpak --user uninstall --delete-data"


