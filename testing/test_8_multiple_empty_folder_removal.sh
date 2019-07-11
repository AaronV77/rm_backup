#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: July 11th, 2019
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to make sure that
# the system is able to remove multiple empty directories at once.
#--------------------------------------------------------------------
mkdir something_1 something_2 something_3
$RUN -rf something_1 something_2 something_3
number_of_files=$(ls -1 $BACKUP/backup| wc -l)
/bin/rm -rf $BACKUP/backup/*
if [ $number_of_files != 3 ]; then
    echo "Not all three folders made their way to the backup correctly."
    exit 1
fi