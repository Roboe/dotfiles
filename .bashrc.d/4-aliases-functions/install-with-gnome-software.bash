## Install local package with Gnome Software
[[ $(which gnome-software) ]] && function software-install {
  gnome-software --local-filename="$1"
}
