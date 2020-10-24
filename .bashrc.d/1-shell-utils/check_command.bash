# POSIX way to test if a command is in PATH and it's executable
# https://stackoverflow.com/q/592620
function test_command {
  test -x "$(command -v $1)"
}
