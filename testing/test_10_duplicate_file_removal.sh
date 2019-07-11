touch something.txt
$RUN something.txt
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    file_time_1=$(stat -c %Y $BACKUP/backup/something.txt)
elif [[ "$OSTYPE" == "darwin"* ]]; then
    file_time_1=$(stat -f %m $BACKUP/backup/something.txt)
fi

sleep 10

touch something.txt
$RUN something.txt
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    file_time_2=$(stat -c %Y $BACKUP/backup/something.txt)
elif [[ "$OSTYPE" == "darwin"* ]]; then
    file_time_2=$(stat -f %m $BACKUP/backup/something.txt)
fi

/bin/rm -rf $BACKUP/backup/*
if [ $file_time_1 == $file_time_2 ]; then
    echo "The backup did not remove the previous file for the new incoming file with the same name."
    exit 1
fi

