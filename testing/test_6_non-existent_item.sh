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