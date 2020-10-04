# POSIX way to check if a command is in PATH and it's executable
# https://stackoverflow.com/q/592620
function check_command {
  test -x "$(command -v $1)"
}
