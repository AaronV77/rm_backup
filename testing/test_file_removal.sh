cd $BACKUP
directory_contents=(*)
if [ ${#directory_contents[@]} != 1 ]; then
    echo "There was something wrong with the contents of .rm_backup."
    exit 1
fi