shopt -s expand_aliases
alias name='echo "Aaaron Valoroso"' >> $HOME/.bashrc
source $HOME/.bashrc
output=$(name)
if [ "$output" != "Aaron Valoroso" ]; then
    echo "Sourcing is not working for some reason."
    exit 1
fi