#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: July 11th, 2019
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to make sure that
# the system is able to remove multiple directories that have contents
# at once. There is also a check to make sure that the contents of each
# directory made it to the backup directory as well.
#--------------------------------------------------------------------
mkdir something_1
cd something_1
touch something.txt
cd ..

mkdir something_2
cd something_2
touch something.txt
cd ..

mkdir something_3
cd something_3
touch something.txt
cd ..

$RUN -rf something_1 something_2 something_3
folder_1=$(ls -1 $BACKUP/backup | wc -l)
folder_2=$(ls -1 $BACKUP/backup/something_1 | wc -l)
folder_3=$(ls -1 $BACKUP/backup/something_2 | wc -l)
folder_4=$(ls -1 $BACKUP/backup/something_3 | wc -l)
/bin/rm -rf $BACKUP/backup/*
if [ $folder_1 != 3 ]; then
    echo "Not all three folders made their way to the backup correctly."
    exit 1
fi
if [ $folder_2 != 1 ]; then
    echo "Not everything made it over to the backup in one of the folders."
    exit 1
fi
if [ $folder_3 != 1 ]; then
    echo "Not everything made it over to the backup in one of the folders."
    exit 1
fi
if [ $folder_4 != 1 ]; then
    echo "Not everything made it over to the backup in one of the folders."
    exit 1
fi