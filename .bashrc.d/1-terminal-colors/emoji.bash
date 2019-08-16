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
