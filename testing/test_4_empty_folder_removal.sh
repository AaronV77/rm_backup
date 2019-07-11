mkdir something
$RUN -rf something
number_of_files=$(ls -1 $BACKUP/backup | wc -l)
/bin/rm -rf $BACKUP/backup/*
if [ $number_of_files != 1 ]; then
    echo "The folder did not get removed/backed up correctly."
    exit 1
fi