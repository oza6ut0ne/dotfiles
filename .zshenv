# zmodload zsh/zprof && zprof

export ZDOTDIR=~/.config/zsh

# Set up Nix on SSH connections with command (non-login shells) for remote build
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ] && [ -n "${SSH_CONNECTION}" ] && [ "${SHLVL}" -eq 1 ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# https://github.com/termux/termux-packages/issues/17485#issuecomment-4416135911
if [ -n "$TERMUX_VERSION" ]; then
    (( $+options[casepaths] )) && setopt casepaths
fi
