
## Wait until network is reachable before continuing
function wait-for-network {
  local DESTINATION=${1:-1.1.1.1}
  local INTERVAL=${2:-0.1}

  while ! ping -q -c1 "$DESTINATION" &>/dev/null
  do sleep "$INTERVAL"
  done
}
