## Alias to query why a package was autoinstalled
check_command apt && alias apt-why='apt rdepends --no-{suggests,conflicts,breaks,replaces,enhances} --installed --recurse'
