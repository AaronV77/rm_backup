#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: August 16th, 2019
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to make sure that
# the system is able to clear out files with similar names by just using 
# the single star (*) feature at the last similar character in the filename.
#--------------------------------------------------------------------
/bin/rm -rf $BACKUP/backup/*
touch something_1.txt something_2.txt something_3.txt

$RUN something_*
number_of_files=$(ls $BACKUP/backup | wc -l)
/bin/rm -rf $BACKUP/backup/*
if [ $number_of_files != 3 ]; then
    echo "The files with similiar names all did not make it to the backup."
    exit 1
fi
exit 0