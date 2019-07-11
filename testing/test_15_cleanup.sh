#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: July 11th, 2019
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to make sure that
# the tear_down script is operating correctly and everything gets cleaned
# off the users system.
#--------------------------------------------------------------------
cd ..
./tear_down.sh

if [ -d $BACKUP ]; then 
    echo "The main rm directory is persisting."
    exit 1
fi

