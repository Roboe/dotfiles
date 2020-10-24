## Install local package with Gnome Software
test_command gnome-software && function software-install {
  gnome-software --local-filename="$1"
}
