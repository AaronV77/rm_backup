mkdir something_1
$RUN -rf something_1
folder_time_1=$(stat -c %Y $HOME/backup/something_1)

sleep 10

mkdir something_2
$RUN -rf something_2
folder_time_2=$(stat -c %Y $HOME/backup/something_2)

/bin/rm -rf $BACKUP/backup/*
if [ $folder_time_1 == $folder_time_2 ]; then
    echo "The backup did not remove the previous folder for the new incoming file with the same name."
    exit 1
fi

