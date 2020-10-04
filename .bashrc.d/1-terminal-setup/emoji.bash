# Emoji codepoints from the amazing http://www.fileformat.info
function emoji {
  local V16="\\UFE0F" # Unicode variation 16. Forces emoji representation
  local NBSP="\\U00A0" # Non-breaking space to fix V16 taking up no space

  local CODEPOINTS
  case "$1" in
    "circular arrows") CODEPOINTS="\\U1F504"          ;;
    "community"      ) CODEPOINTS="\\U1F465"          ;;
    "cup"            ) CODEPOINTS="\\U2615"           ;;
    "download"       ) CODEPOINTS="\\U1F4E5"          ;;
    "package"        ) CODEPOINTS="\\U1F4E6"          ;;
    "tornado"        ) CODEPOINTS="\\U1F32A$V16$NBSP" ;;
    "traffic light"  ) CODEPOINTS="\\U1F6A6"          ;;
    "whirlpool"      ) CODEPOINTS="\\U1F300"          ;;
  esac

  echo -en "$CODEPOINTS"
}
