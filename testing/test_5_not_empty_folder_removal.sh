mkdir something
cd something
touch something.txt
cd ..

$RUN -rf something
folder_1=$(ls -1 $BACKUP/backup | wc -l)
folder_2=$(ls -1 $BACKUP/backup/something | wc -l)
/bin/rm -rf $BACKUP/backup/*
if [ $folder_1 != 1 ]; then
    echo "The folder did not get removed/backed up correctly."
    exit 1
fi
if [ $folder_2 != 1 ]; then
    echo "Not everything made it over to the backup."
    exit 1
fi