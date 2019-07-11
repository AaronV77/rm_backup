cd ..
./tear_down.sh

if [ -d $BACKUP ]; then 
    echo "The main rm directory is persisting."
    exit 1
fi

