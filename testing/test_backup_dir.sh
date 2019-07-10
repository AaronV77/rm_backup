shopt -s expand_aliases
source $HOME/.bashrc
echo "----------------------------"
cat $HOME/.bashrc
echo "----------------------------"
touch something.txt
rm something.txt --verbose
if [ ! -d $BACKUP ]; then 
    echo "The rm_backup directory could not be found in the '$HOME' directory."
    exit 1
else 
    /bin/rm -rf $BACKUP/*
fi