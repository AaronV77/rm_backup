touch something.txt
$RUN something.txt

/bin/rm -rf $BACKUP/backup/*
number_of_files=$(ls -1 $BACKUP/backup| wc -l)

if [ ${#directory_contents[@]} != 1 ]; then
    echo "There was something wrong with the contents of .rm_backup."
    exit 1
fi