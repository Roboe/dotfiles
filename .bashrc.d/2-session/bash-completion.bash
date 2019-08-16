# enable programmable completion features (you don't need to enable
# this if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix
then
  if [[ -f /usr/share/bash-completion/bash_completion ]]
  then source /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]
  then source /etc/bash_completion
  fi
fi


# case-insensitive completions
bind "set completion-ignore-case on"


# single tab completion
bind "set show-all-if-ambiguous on"


# git completion (Fedora)
if [[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]]
then source /usr/share/git-core/contrib/completion/git-prompt.sh
fi

