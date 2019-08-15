#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: July 11th, 2019
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to be able to remove
# any artifact of the rm_backup application. 
#--------------------------------------------------------------------
# In this section of code all I am checking for the rm alias in either the
# - .bashrc or .bash_profile file. If I only find one occurence of the alias
# - I will remove it, and if there are more than one occurence then I will
# - print an error and exit. Lastly, I delete the .rm_backup directory in the
# - users $HOME directory.
occurences=$(grep -o "rm ()" $HOME/.bashrc | wc -l)
if [ $((occurences)) -eq 1 ]; then
    line_number=$(grep -nr "rm ()" $HOME/.bashrc | cut -d: -f1)
    sed -i $line_number'd' $HOME/.bashrc
elif [ $((occurences)) -gt 1 ]; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        echo "Your .bashrc is littered with rm () aliases, please clean up."
    elif [[ "$OSTYPE" == "darwin"* ]]; then 
        echo "Your .bash_profile is littered with rm () aliases, please clean up."
    fi
    exit 1
fi
if [ -d $HOME/.rm_backup ]; then /bin/rm -rf $HOME/.rm_backup; fi
#--------------------------------------------------------------------