# Node Version Management setup
export N_PREFIX="$HOME/.local/node"

[[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

function n_install {
  [[ -d $N_PREFIX ]] && echo "$N_PREFIX already exist" && return

  echolorize "$(emoji "package") Downloading n"
  mkdir $N_PREFIX
  git clone https://github.com/tj/n.git $N_PREFIX/n

  echolorize "$(emoji "download") Installing n"
  (cd $N_PREFIX/n && PREFIX=$N_PREFIX make install)

  echolorize "$(emoji "download") Installing latest LTS node"
  n lts
}

