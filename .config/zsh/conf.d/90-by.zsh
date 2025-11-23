# Ref: https://github.com/atusy/by-binds-yourself
typeset -g ___by_commandline_prefix=""
unset ___by_commandline_prefix

function by() {
  if [[ "$#" -gt 0 ]]; then
    ___by_commandline_prefix="$*"
  else
    unset ___by_commandline_prefix
  fi
}

function ___by() {
  if [[ -v ___by_commandline_prefix ]]; then
    BUFFER="$___by_commandline_prefix "
    CURSOR=$#BUFFER
  fi
}

zle -N zle-line-init ___by
