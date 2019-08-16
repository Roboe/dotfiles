## Dim the screen brightness level, mainly for CLI terminals
## Pass a percentage as the only parameter
function dim {
  if [[ $1 -lt 1 ]]
  then
    echo "Turning off your screen is dangerous because the change persist after reboots"
    return
  fi

  MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness)
  DESIRED_BRIGHTNESS=$(expr ${1} * ${MAX_BRIGHTNESS} / 100)
  echo $DESIRED_BRIGHTNESS | sudo tee /sys/class/backlight/intel_backlight/brightness
}
