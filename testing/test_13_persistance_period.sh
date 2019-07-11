#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: July 11th, 2019
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to check to make
# sure that the system is removing files from the backup when their
# persistence time has expired.
#--------------------------------------------------------------------
touch something_1.txt
$RUN something_1.txt

sleep 70s

touch something_2.txt
$RUN something_2.txt

number_of_files=$(ls -1 $BACKUP/backup | wc -l)
/bin/rm -rf $BACKUP/backup/*
if [ $number_of_files != 1 ]; then
    echo "The persistance time is not removing old files / folders from the backup."
    exit 1
fi
