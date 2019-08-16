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
