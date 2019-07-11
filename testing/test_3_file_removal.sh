touch something.txt
$RUN something.txt
number_of_files=$(ls -1 $BACKUP/backup| wc -l)
/bin/rm -rf $BACKUP/backup/*
if [ $number_of_files != 1 ]; then
    echo "The file did not get removed/backed up correctly."
    exit 1
fi