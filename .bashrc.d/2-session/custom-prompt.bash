# Change prompt
function change_prompt {
  # Wrapping the tput output in \[ \] is recommended by the Bash man page. This helps Bash ignore non printable characters so that it correctly calculates the size of the prompt.
  local RESET="\\[$(tput sgr0)\\]" # reset text attributes
  local BOLD="\\[$(tput bold)\\]" # bold text
  local GREEN="\\[$(tput setaf 2)\\]" # green text
  local BLUE="\\[$(tput setaf 4)\\]" # blue text

  PS1=""
  PS1+="┌─╼[$BOLD$BLUE\\h$RESET]╾─╼[$GREEN\\w$RESET]\$(__git_ps1) \\n"
  PS1+="└╼ $BOLD\$$RESET "
}
change_prompt


# Change the terminal title bar to always display the current directory
#PROMPT_COMMAND='echo -ne "\e]0;$(pwd -P)\a"'
