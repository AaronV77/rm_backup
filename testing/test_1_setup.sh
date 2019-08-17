#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: July 11th, 2019
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to check
#--------------------------------------------------------------------
bash_file_type=0
if [[ "$OSTYPE" == "darwin"* ]]; then
    bash_file_type=".bashrc_profile"
elif [["$OSTYPE" == "linux-gn" ]]; then
    bash_file_type=".bashrc"
else
    echo "Your OS is not supported..."
    exit 1;
fi

occurences=$(grep -o "rm ()" $HOME/.$bash_file_type | wc -l)
if [ $((occurences)) -eq 0 ]; then
    echo "There is no alias in your .$bash_file_type"
    exit 1
fi

exit 0