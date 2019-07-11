mkdir something
cd something
touch something_1.txt something_2.txt
cd ..

$RUN -rf something/*
number_of_files_=$(ls -1 $BACKUP/backup | wc -l)
/bin/rm -rf $BACKUP/backup/*
if [ $number_of_files != 2 ]; then
    echo "The folder did not get removed/backed up correctly."
    exit 1
fi
if [ ! -d something ]; then
    echo "The existing folder did not stay around after deleteing everything in the folder."
    exit 1
fi
$RUN -rf something