function starship_transient_prompt_func
    starship module character
end

function starship_transient_rprompt_func
    starship module cmd_duration
end

if status is-interactive
    # abbr --add cdd "cd $(find * -type d | fzf)"
end

starship init fish | source
zoxide init --cmd cd fish | source
set -gx EDITOR nvim

enable_transience
