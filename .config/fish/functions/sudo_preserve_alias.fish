# https://github.com/fish-shell/fish-shell/issues/7044#issuecomment-2222410290
function sudo --wraps sudo
    set sudo_args_with_value (LANG=C command sudo --help | string match -gr '^\s*(-\w),\s*(--\w[\w-]*)=')
    set sudo_args

    while set -q argv[1]
        switch "$argv[1]"
            case '--'
                set -a sudo_args $argv[1]
                set -e argv[1]
                break
            case $sudo_args_with_value
                set -a sudo_args $argv[1]
                set -e argv[1]
            case '-*'
            case '*'
                break
        end
        set -a sudo_args $argv[1]
        set -e argv[1]
    end

    if functions -q -- $argv[1]
        set -- argv fish -C "$(functions --no-details -- $argv[1])" -c '$argv' -- $argv
    end

    command sudo $sudo_args $argv
end
