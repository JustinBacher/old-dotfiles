zoxide init --cmd cd fish | source
set -gx EDITOR nvim

if status is-interactive
    and not set -q TMUX
    exec tmux 
end
