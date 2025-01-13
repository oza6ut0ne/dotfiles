if which aichat >/dev/null 2>&1
    function _aichat_fish
        set -l _old (commandline)
        if test -n $_old
            echo -n "⌛"
            commandline -f repaint
            commandline (echo -n (aichat -e $_old) | string trim -r)
        end
    end

    bind \er _aichat_fish
end
