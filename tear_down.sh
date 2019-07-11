
occurences=$(grep -o "rm ()" $HOME/.bashrc | wc -l)
echo "Number of occurences: $occurences"
if [ $occurences > 0 ]; then
    if [ $occurences == 1 ]; then
        line_number=$(grep -nr "rm ()" $HOME/.bashrc | cut -d: -f1)
        sed -i $line_number'd' $HOME/.bashrc
    elif [ $occurences > 1 ]; then
        if [[ "$OSTYPE" == "linux-gnu" ]]; then
            echo "Your .bashrc is littered with rm () aliases, please clean up."
        elif [[ "$OSTYPE" == "darwin"* ]]; then 
            echo "Your .bash_profile is littered with rm () aliases, please clean up."
        fi
        exit 1
    fi
fi
if [ -d $BACKUP ]; then /bin/rm -rf $BACKUP; fi