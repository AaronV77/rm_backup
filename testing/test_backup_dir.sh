source $HOME/.bashrc
touch something.txt
rm something.txt --verbose
echo "=============================="
cat $HOME/.bashrc
echo "=============================="
echo $HOME
pwd
echo "=============================="
ls $HOME
echo "=============================="
ls $HOME/build/AaronV77
echo "=============================="
if [ ! -d $BACKUP ]; then 
    echo "The rm_backup directory could not be found in the '$HOME' directory."
    exit 1
else 
    /bin/rm -rf $BACKUP/*
fi