# Python 3 by default if available
## To use Python 2, use 'python2' instead
check_command python3 && alias python='python3'


# Python VirtualEnvWrapper setup
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
VIRTUALENVWRAPPER_INIT=/usr/local/bin/virtualenvwrapper.sh
[[ -r "$VIRTUALENVWRAPPER_INIT" ]] && source "$VIRTUALENVWRAPPER"
