function dot --wraps='nvim ~/dotfiles' --wraps='cd ~/dotfiles && nvim .' --description 'alias dot cd ~/dotfiles && nvim .'
  cd ~/dotfiles && nvim . $argv
        
end
