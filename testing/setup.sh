#!/bin/bash

#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: December 17th, 2018
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
re='^[0-9]*$'
progression=()
#--------------------------------------------------------------------
# Get the time duration on how long the user wants the files to persist.
months=0
weeks=0
days=0
hours=0
minutes=2
let total_seconds="$(($months))+$(($weeks))+$(($days))+$(($hours))+$(($minutes))"
#--------------------------------------------------------------------
# Create a copy of the rm_alias file to not ruin the original copy.
touch copy_alias
cat ../rm_alias >> copy_alias

# Find the location in the rm alias file and replace it with the total seconds.
sed -i -e 's/TOTAL-TIME/'$total_seconds'/g' copy_alias

# Put the correct stat arguments in the file.
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sed -i -e 's/ARGUMENTS/-c %Y/g' copy_alias
elif [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i -e 's/ARGUMENTS/-f %m/g' copy_alias
else
    echo "ERROR: Can't tell what OS you have..."
    if [ -f copy_alias ]; then /bin/rm copy_alias; fi
    if [ -f copy_alias-e ]; then /bin/rm copy_alias-e; fi
    exit
fi
#--------------------------------------------------------------------
# Find what lines the alias is on for both the start and end. I put comments
# - in the file to give me key spots to find and can trust that I won't find
# - anywhere else in the file.
if [ -f $HOME/.bashrc ]; then
    occurences=$(grep -o '# START' $HOME/.bashrc | wc -l)
    if [ $occurences -gt 1 ]; then
        echo "The '# START' was found $occurences times in the .bashrc..."
        exit
    fi

    occurences=$(grep -o '# END' $HOME/.bashrc | wc -l)
    if [ $occurences -gt 1 ]; then
        echo "The '# END' was found $occurences times in the .bashrc..."
        exit
    fi

    line_1=$(grep -n "# START" $HOME/.bashrc | cut -d : -f 1)
    line_2=$(grep -n "# END" $HOME/.bashrc | cut -d : -f 1)
elif [ -f $HOME/.bash_profile ]; then
    occurences=$(grep -o '# START' $HOME/.bash_profile | wc -l)
    if [ $occurences -ge 1 ] && [ $occurences -le 0 ]; then
        echo "The '# START' was found $occurences times in the .bash_profile..."
        exit
    fi

    occurences=$(grep -o '# END' $HOME/.bash_profile | wc -l)
    if [ $occurences -ge 1 ] && [ $occurences -le 0 ]; then
        eecho "The '# END' was found $occurences times in the .bash_profile..."
        exit
    fi

    line_1=$(grep -n "# START" $HOME/.bash_profile | cut -d : -f 1)
    line_2=$(grep -n "# END" $HOME/.bash_profile | cut -d : -f 1)
else
    echo "There was an error trying to find your .bashrc or .bash_profile..."
    exit
fi
#--------------------------------------------------------------------
# Move the first line back one, and the second line forward one to get
# - the full length of the rm alias. Then delete the rm alaias from the
# - file with the given range of lines.
if [ ! -z "$line_1" ] || [ ! -z "$line_2" ]; then
    echo "Replacing the alias in the file."
    line_1=$(($line_1 - 1))
    line_2=$(($line_2 + 1))
    if [ -f $HOME/.bashrc ]; then
        sed -i -e "$(($line_1)),$(($line_2))d" $HOME/.bashrc
    elif [ -f $HOME/.bash_profile ]; then
        sed -i -e "$(($line_1)),$(($line_2))d" $HOME/.bash_profile
    fi
fi

# Add the alias to the end of the file.
if [ -f $HOME/.bashrc ]; then
    cat copy_alias >> $HOME/.bashrc
elif [ -f $HOME/.bash_profile ]; then
    cat copy_alias >> $HOME/.bash_profile
fi

#--------------------------------------------------------------------
# Delete the backup copy of the file.
if [ -f copy_alias ]; then /bin/rm copy_alias; fi
if [ -f copy_alias-e ]; then /bin/rm copy_alias-e; fi
chmod 644 *

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    source $HOME/.bashrc
elif [[ "$OSTYPE" == "darwin"* ]]; then
    source $HOME/.bash_profile
fi