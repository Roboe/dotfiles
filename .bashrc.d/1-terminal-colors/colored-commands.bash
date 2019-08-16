# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]
then
  test -r ~/.dircolors && eval "$(dircolors --sh ~/.dircolors)" || eval "$(dircolors --sh)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias diff='diff --color=auto'
fi
