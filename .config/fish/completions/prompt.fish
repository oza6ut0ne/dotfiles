complete -c prompt -n "__fish_prompt_arg1" -f -a "oneline short git label venv starship"

complete -c prompt -n "__fish_prompt_arg2_values" -f -a "0 1"
complete -c prompt -n "__fish_prompt_arg2_otherwise" -f -a ""

complete -c prompt -n "__fish_prompt_too_many_args" -f -a ""


function __fish_prompt_arg1
    set -l words (commandline -opc)
    test (count $words) -eq 1
end

function __fish_prompt_arg2_values
    set -l words (commandline -opc)
    test (count $words) -eq 2
    and contains -- "$words[2]" oneline short git
end

function __fish_prompt_arg2_otherwise
    set -l words (commandline -opc)
    test (count $words) -eq 2
    and not contains -- "$words[2]" oneline short git
end

function __fish_prompt_too_many_args
    set -l words (commandline -opc)
    test (count $words) -ge 3
end
