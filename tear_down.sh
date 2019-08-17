#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: August 16th, 2019
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
bash_file_type=0
if [[ "$OSTYPE" == "darwin"* ]]; then
    bash_file_type=".bashrc_profile"
elif [["$OSTYPE" == "linux-gn" ]]; then
    bash_file_type=".bashrc"
else
    echo "Your OS is not supported..."
    exit 1;
fi

occurences=$(grep -o "rm ()" $HOME/.$os_type | wc -l)
if [ $((occurences)) -eq 1 ]; then
    line_number=$(grep -nr "rm ()" $HOME/.$os_type | cut -d: -f1)
    sed -i $line_number'd' $HOME/.bashrc
elif [ $((occurences)) -gt 1 ]; then
    echo "Your .$os_type is littered with rm () aliases, please clean up."
    exit 1
fi
if [ -d $HOME/.rm_backup ]; then /bin/rm -rf $HOME/.rm_backup; fi
#--------------------------------------------------------------------