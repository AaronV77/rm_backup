touch something.txt
rm something.txt

if [ ! -d $BACKUP ]; then 
    ls -la $HOME
    echo "The rm_backup directory could not be found in the '$HOME' directory."
    exit 1
else 
    /bin/rm -rf $BACKUP/*
fi