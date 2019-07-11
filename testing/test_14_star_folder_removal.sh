#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: July 11th, 2019
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to make sure that
# the system is able to clear out the contents of a directory.
#--------------------------------------------------------------------
mkdir something
cd something
touch something_1.txt something_2.txt
cd ..

$RUN -rf something/*
number_of_files=$(ls -1 $BACKUP/backup | wc -l)
/bin/rm -rf $BACKUP/backup/*
if [ $number_of_files != 2 ]; then
    echo "The folder did not get removed/backed up correctly."
    exit 1
fi
if [ ! -d something ]; then
    echo "The existing folder did not stay around after deleteing everything in the folder."
    $RUN -rf something
    exit 1
fi
$RUN -rf something
exit 0