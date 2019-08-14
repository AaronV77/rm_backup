#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: July 11th, 2019
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to make sure that
# the system is able to clear out files with similar names by just using 
# the single star (*) feature at the last similar character in the filename.
#--------------------------------------------------------------------
touch something_1.txt something_2.txt something_3.txt

$RUN something_*
number_of_files=$(ls -1 $BACKUP/backup | wc -l)
# /bin/rm -rf $BACKUP/backup/*
if [ $number_of_files != 3 ]; then
    echo "The files with similiar names all did not make it to the backup."
    echo "Found: $number_of_files"
    ls $BACKUP/backup/*
    exit 1
fi
exit 0