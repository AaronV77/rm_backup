#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: July 11th, 2019
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to make sure that
# the system is able to remove an empty directories.
#--------------------------------------------------------------------
mkdir something
$RUN -rf something
number_of_files=$(ls -1 $BACKUP/backup | wc -l)
/bin/rm -rf $BACKUP/backup/*
if [ $number_of_files != 1 ]; then
    echo "The folder did not get removed/backed up correctly."
    exit 1
fi