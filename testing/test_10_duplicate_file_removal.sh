#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: July 11th, 2019
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to check to make
# sure that the system is able to remove a file with the same name
# twice. The objective is to see if the old version gets removed and 
# the new one takes its place in the backup directory.
#--------------------------------------------------------------------
touch something.txt
$RUN something.txt
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    file_time_1=$(stat -c %Y $BACKUP/backup/something.txt)
elif [[ "$OSTYPE" == "darwin"* ]]; then
    file_time_1=$(stat -f %m $BACKUP/backup/something.txt)
fi

sleep 10

touch something.txt
$RUN something.txt
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    file_time_2=$(stat -c %Y $BACKUP/backup/something.txt)
elif [[ "$OSTYPE" == "darwin"* ]]; then
    file_time_2=$(stat -f %m $BACKUP/backup/something.txt)
fi

/bin/rm -rf $BACKUP/backup/*
if [ $file_time_1 == $file_time_2 ]; then
    echo "The backup did not remove the previous file for the new incoming file with the same name."
    exit 1
fi

