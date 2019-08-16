# System maintenance
## Disks relation
alias disk='df --human-readable | grep -e /dev/sd -e Filesystem' # Show disk information

## Restart NetworkManager service
alias renm='sudo systemctl restart NetworkManager'
