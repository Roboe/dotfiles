# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Differences between [ and [[: http://mywiki.wooledge.org/BashFAQ/031

function load_dotfiles {
  for SCRIPT in ~/.bashrc.d/"$1"/*.bash
  do source "$SCRIPT"
  done
}

# ----------- #
# SHELL UTILS #
# ----------- #

load_dotfiles 1-shell-utils


# --------------- #
# SESSION SETUPS  #
# --------------- #

load_dotfiles 2-session


# ------------------- #
# DEVELOP ENVIRONMENT #
# ------------------- #

load_dotfiles 3-dev-environment


# --------------------- #
# ALIASES AND FUNCTIONS #
# --------------------- #

load_dotfiles 4-aliases-functions


# ---------------- #
# GRAPHICAL OUTPUT #
# ---------------- #

load_dotfiles 5-graphical-output
