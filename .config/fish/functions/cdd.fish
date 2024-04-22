function cdd --wraps='cd ' --description 'alias cdd cd $(find * -type d | fzf)'
    cd $(find * -type d | fzf)
end
