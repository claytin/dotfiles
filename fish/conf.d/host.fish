if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname)
end

set -x HOST $__fish_prompt_hostname
