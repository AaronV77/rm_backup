#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: July 11th, 2019
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to make sure that
# the system is able to remove directories that have contents and that
# the contents of said directory make it to the backup.
#--------------------------------------------------------------------
mkdir something
cd something
touch something.txt
cd ..

$RUN -rf something
folder_1=$(ls -1 $BACKUP/backup | wc -l)
folder_2=$(ls -1 $BACKUP/backup/something | wc -l)
/bin/rm -rf $BACKUP/backup/*
if [ $folder_1 != 1 ]; then
    echo "The folder did not get removed/backed up correctly."
    exit 1
fi
if [ $folder_2 != 1 ]; then
    echo "Not everything made it over to the backup."
    exit 1
fi