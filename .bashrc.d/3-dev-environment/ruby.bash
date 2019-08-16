# Add Ruby user gems to PATH
export GEMS_DIR="$HOME/.gem"

[[ -r "$GEMS_DIR" ]] && export PATH="$PATH:$(ls -td -- $GEMS_DIR/ruby/*/ | head -n 1)bin"
