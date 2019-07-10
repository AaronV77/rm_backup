touch something.txt
ls $HOME
ls $HOME/.rm_backup
ls $HOME/.rm_backup/script
$RUN something.txt
if [ ! -d $BACKUP ]; then 
    echo "The rm_backup directory could not be found in the '$HOME' directory."
    exit 1
else 
    /bin/rm -rf $BACKUP/backup/*
fi