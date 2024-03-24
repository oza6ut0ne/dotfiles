function git_is_git_dir
  test (git rev-parse --is-inside-git-dir) = "true"
end

function git_is_dubious_repo
  git rev-parse 2>&1 >/dev/null | grep -q 'fatal: detected dubious ownership'
end

function git_is_bare_repo
  test (git rev-parse --is-bare-repository) = "true"
end

function git_is_untracked
  git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>&1
end

function git_is_dirty
  not git_is_git_dir; and not git_is_bare_repo; and begin
    not git diff --no-ext-diff --quiet 2>/dev/null
  end
end

function git_is_indexed
  not git diff --no-ext-diff --cached --quiet
end

function git_is_rebasing
  set -l git_dir (git rev-parse --git-dir)
  test -d "$git_dir/rebase-merge" -o -d "$git_dir/rebase-apply"
end

function git_is_merging
  set -l git_dir (git rev-parse --git-dir)
  test -f "$git_dir/MERGE_HEAD"
end

function git_is_bisecting
  set -l git_dir (git rev-parse --git-dir)
  test -f "$git_dir/BISECT_LOG"
end

function git_has_conflicts
  set -l conflicts (git ls-files --unmerged 2>/dev/null)
  test "$conflicts" != ""
end

function fish_prompt
  set -l last_command_statuses $pipestatus

  set -l cwd (prompt_pwd)
  if test "$PROMPT_SHORT_PATH" = "1"
    set cwd (basename $cwd)
  end

  if test (id -u) -eq 0
    set prompt_character "#"
  else
    set prompt_character "\$"
  end

  set -l fish      "⋊>"
  set -l stashed   '$'
  set -l untracked "?"
  set -l dirty     "!"
  set -l indexed   "+"
  set -l ahead     ">"
  set -l behind    "<"
  set -l diverged  "><"
  set -l none      ""

  set -l normal_color     (set_color normal)
  set -l success_color    (set_color bryellow)
  set -l error_color      (set_color $fish_color_error 2>/dev/null; or set_color red --bold)
  set -l directory_color  (set_color brcyan)
  set -l repository_color (set_color bryellow)

  set -l status_color $success_color
  for command_status in $last_command_statuses
    if test $command_status -ne 0
      set status_color $error_color
      break
    end
  end
  echo -n -s $status_color
  echo -n $last_command_statuses
  echo -n -s $normal_color "|"

  echo -n -s (whoami) "@" (prompt_hostname)

  if test "$PROMPT_GIT_STATUS" = "1"; and git_is_dubious_repo
    echo -n -s ":" $directory_color $cwd $normal_color
    echo -n -s $error_color "[DUBIOUS]"
  else if test "$PROMPT_GIT_STATUS" = "1"; and git_is_repo
    if test "$PROMPT_SHORT_PATH" = "1" -a "$theme_git_path" = 'yes'
      if not git_is_git_dir
        set root_folder (command git rev-parse --show-toplevel 2>/dev/null)
        set parent_root_folder (dirname $root_folder)
        set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
      end
    end

    echo -n -s ":" $directory_color $cwd $normal_color
    echo -n -s $repository_color "[" (git_branch_name) "]"
    if git_is_bare_repo
      echo -n -s b
    else if git_is_git_dir
      echo -n -s g
    end
    if git_is_stashed
      echo -n -s $stashed
    end
    if git_is_untracked
      echo -n -s $untracked
    end
    if git_is_dirty
      echo -n -s $dirty
    end
    if git_is_indexed
      echo -n -s $indexed
    end
    if git_is_rebasing
      echo -n -s R
    end
    if git_is_merging
      echo -n -s M
    end
    if git_is_bisecting
      echo -n -s B
    end
    if git_has_conflicts
      echo -n -s C
    end
    echo -n -s (git_ahead $ahead $behind $diverged $none)
  else
    echo -n -s ":" $directory_color $cwd $normal_color
  end

  echo -n -s $normal_color
  echo -n -s $prompt_character " "
end
