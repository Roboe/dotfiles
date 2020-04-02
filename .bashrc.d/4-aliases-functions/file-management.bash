# File management and navigation
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

## Permission management (change dir/file mode recursive)
alias chdmodr='find -type d -print0 | xargs -0 chmod'
alias chfmodr='find -type f -print0 | xargs -0 chmod'
