# From ArchWiki: https://wiki.archlinux.org/index.php/Bash/Prompt_customization#Common_capabilities
function echolorize {
  local RST="$(tput sgr0)" # reset text

  local CLR
  case "$1" in
    "--title" ) CLR="$(tput bold)$(tput smso)" && shift ;; # highlighted text
    "--danger") CLR="$(tput setab 1)"          && shift ;; # red background
    "--advise") CLR="$(tput setab 3)"          && shift ;; # yellow background
    *         ) CLR="$(tput setab 4)"                   ;; # blue background (default)
  esac

  [[ "$#" != 0 ]] && echo -e "${CLR} $* ${RST}"
}
