case "$OSTYPE" in
    
    darwin) # running mac
        ./setup/mac/base.sh
    
    *) # assume arch based 
        ./setup/arch/base.sh

esac