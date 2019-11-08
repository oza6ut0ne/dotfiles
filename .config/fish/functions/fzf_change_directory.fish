function fzf_change_directory
  for dir in (ghq list -p) (ls -F | grep /); echo -en -s $dir "\0"; end | eval "fzf --read0 +s --tiebreak=index --toggle-sort=ctrl-r $FZF_DEFAULT_OPTS $FZF_REVERSE_ISEARCH_OPTS -q (commandline)" | read -z select
  if not test -z $select
#    commandline -rb (builtin string trim "$select")
#    commandline -f repaint
    cd (builtin string trim "$select")
  end
  commandline -f repaint
end
