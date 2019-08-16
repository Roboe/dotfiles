# Terminal navigation
## Shorter 'ls'
alias ll='ls --all --format=long --classify'
alias la='ls --classify'
alias l='ls --format=vertical --classify'

## Suspenseful 'cd' (pun intended)
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

## Quick 'mkdir' and 'cd' to new folder
function mkd {
  mkdir --parents "$@" && cd "$@"
}
