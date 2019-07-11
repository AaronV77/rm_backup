touch something_1.txt something_2.txt something_3.txt
$RUN something_1.txt something_2.txt something_3.txt
number_of_files=$(ls -1 $BACKUP/backup| wc -l)
/bin/rm -rf $BACKUP/backup/*
if [ $number_of_files != 3 ]; then
    echo "Not all three files made their way to the backup correctly."
    exit 1
fi