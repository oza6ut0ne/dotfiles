if exists "aichat"; then
    _aichat_zsh() {
        if [[ -n "$BUFFER" ]]; then
            local _old=$BUFFER
            BUFFER+="⌛"
            zle -I && zle redisplay
            BUFFER=$(aichat -e "$_old")
            zle end-of-line
        fi
    }

    zle -N _aichat_zsh
    bindkey '\er' _aichat_zsh
fi
