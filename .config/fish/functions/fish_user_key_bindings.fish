function fish_user_key_bindings
    #bind -e \eO
    bind \c] 'fzf_change_directory'
    bind \033\033 'commandline -f repaint; echo; fuck'
end
