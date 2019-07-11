touch something_1.txt
$RUN something_1.txt

sleep 1m 10s

touch something_2.txt
$RUN something_2.txt

number_of_files=$(ls -1 $BACKUP/backup | wc -l)
/bin/rm -rf $BACKUP/backup/*
if [ $number_of_files != 1 ]; then
    echo "The persistance time is not removing old files / folders from the backup."
    exit 1
fi
