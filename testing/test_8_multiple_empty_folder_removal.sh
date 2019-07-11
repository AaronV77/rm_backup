mkdir something_1 something_2 something_3
$RUN -rf something_1 something_2 something_3
number_of_files=$(ls -1 $BACKUP/backup| wc -l)
/bin/rm -rf $BACKUP/backup/*
if [ $number_of_files != 3 ]; then
    echo "Not all three folders made their way to the backup correctly."
    exit 1
fi