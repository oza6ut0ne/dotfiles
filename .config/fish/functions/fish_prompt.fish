function fish_prompt
  set -l last_command_statuses $pipestatus
  set -l cwd

  if test "$theme_short_path" = 'yes'
    set cwd (basename (prompt_pwd))
  else
    set cwd (prompt_pwd)
  end

  if test (id -u) -eq 0
    set prompt_character "#"
  else
    set prompt_character "\$"
  end

  set -l fish     "⋊>"
  set -l ahead    "↑"
  set -l behind   "↓"
  set -l diverged "⥄ "
  set -l dirty    "⨯"
  set -l none     "◦"

  set -l normal_color     (set_color normal)
#  set -l success_color    (set_color $fish_pager_color_progress ^/dev/null; or set_color cyan)
  set -l success_color    (set_color bryellow)
  set -l error_color      (set_color $fish_color_error ^/dev/null; or set_color red --bold)
#  set -l directory_color  (set_color $fish_color_quote ^/dev/null; or set_color brown)
  set -l directory_color  (set_color brcyan)
#  set -l repository_color (set_color $fish_color_cwd ^/dev/null; or set_color green)
  set -l repository_color (set_color bryellow)

  set -l status_color $success_color
  for command_status in $last_command_statuses
    if test $command_status -ne 0
      set status_color $error_color
      break
    end
  end
# echo -n -s $error_color $fish $normal_color
  echo -n -s $status_color
  echo -n $last_command_statuses
  echo -n -s $normal_color "|"

  echo -n -s (whoami) "@" (cat /etc/hostname)

  if git_is_repo
    if test "$theme_short_path" = 'yes'
      set root_folder (command git rev-parse --show-toplevel ^/dev/null)
      set parent_root_folder (dirname $root_folder)
      set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
    end

#    echo -n -s " " $directory_color $cwd $normal_color
#    echo -n -s " on " $repository_color (git_branch_name) $normal_color " "
    echo -n -s ":" $directory_color (basename (prompt_pwd)) $normal_color
    echo -n -s $repository_color "[" (git_branch_name) "]" $normal_color 
    if git_is_touched
      echo -n -s $dirty
    else
      echo -n -s (git_ahead $ahead $behind $diverged $none)
    end
  else
#    echo -n -s " " $directory_color $cwd $normal_color
    echo -n -s ":" $directory_color (basename (prompt_pwd)) $normal_color 
  end

  echo -n -s $prompt_character " "
end
