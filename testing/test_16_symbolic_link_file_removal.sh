#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: August 9th, 2021
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to make sure that
# - the system is able to remove a symbolic link.
#--------------------------------------------------------------------
mkdir something
ln -snf something temp

if [ -L "temp" ]; 
then
    $RUN -rf temp
    if [ -L "temp" ];
    then
        echo "The symbolic link did not get removed correctly."
	exit 1
    fi
fi
