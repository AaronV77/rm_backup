#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: August 9th, 2021
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# # General File Overview: The mission for this file is to make sure that
# the system is able to remove a folder with spaces in its name..
#--------------------------------------------------------------------
mkdir something\ folder
$RUN -rf something\ folder
number_of_files=$(ls -1 $BACKUP/backup| wc -l)
/bin/rm -rf $BACKUP/backup/*
if [ $number_of_files != 1 ]; then
    echo "The file did not get removed/backed up correctly."
    exit 1
fi

