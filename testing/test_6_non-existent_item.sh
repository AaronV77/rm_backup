#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: July 11th, 2019
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to check to make
# sure that the system handled trying to delete an item that did not 
# exist or generate something in the backup directory.
#--------------------------------------------------------------------
command_output=$($RUN something.txt)
number_of_files=$(ls -1 $BACKUP/backup| wc -l)
if [ "$command_output" != "Can't delete the following: something.txt, because its nonexistent." ]; then
    echo "The system generated the wrong output, the output is below: "
    echo $command_output
fi
if [ $number_of_files != 0 ]; then
    echo "There was something wrong with the contents of .rm_backup."
    exit 1
fi