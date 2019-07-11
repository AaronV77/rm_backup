mkdir something_1
cd something_1
touch something.txt
$RUN -rf something_1
folder_time_1=$(stat -c %Y $BACKUP/backup/something_1)
file_time_1=$(stat -c %Y $BACKUP/backup/something_1/something.txt)

sleep 10

mkdir something_1
cd something_1
touch something.txt
$RUN -rf something_1
folder_time_2=$(stat -c %Y $BACKUP/backup/something_1)
file_time_2=$(stat -c %Y $BACKUP/backup/something_1/something.txt)

/bin/rm -rf $BACKUP/backup/*
if [ $folder_time_1 == $folder_time_2 ]; then
    echo "The backup did not remove the previous folder for the new incoming folder with the same name."
    exit 1
fi
if [ $file_time_1 == $file_time_2 ]; then
    echo "The backup did not remove the previous folder contents for the new incoming folder with the same name."
    exit 1
fi