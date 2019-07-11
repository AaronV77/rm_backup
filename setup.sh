#!/bin/bash

#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: December 17th, 2018
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# Just a basic cleanup function that cleanup after the script.
cleanup () {
    echo -e "\tCleaning up...."

    if [ -f copy_alias ]; then /bin/rm copy_alias; fi
    if [ -f copy_alias-e ]; then /bin/rm copy_alias-e; fi

    echo "Exiting..."
    cd $current_directory || cd $HOME
    chmod 644 *
    exit 1
}
trap cleanup 1 2 3 6
#--------------------------------------------------------------------
get_numbers () {
    while true; do
        read -p "$1: " temp

        if ! [[ $temp =~ $re ]] || [ -z "$temp" ]; then
            echo -e "\tError: The number you have entered is not considered a number in this script."
        else
            # Calculate the total number of seconds from the given input.
            case $1 in
                "Months") 
                    if [ $(($temp)) -le 12 ]; then
                        let temp="$(($temp)) * 30 * 24 * 3600"
                    else
                        echo "The number you have entered was too high..."
                        continue
                    fi
                    ;;
                "Weeks") 
                    if [ $(($temp)) -le 53 ]; then
                        let temp="$(($temp)) * 7 * 24 * 3600"
                    else
                        echo "The number you have entered was too high..."
                        continue
                    fi
                    ;;
                "Days") 
                    if [ $(($temp)) -le 365 ]; then
                        let temp="$(($temp)) * 24 * 3600"
                    else
                        echo "The number you have entered was too high..."
                        continue
                    fi
                    ;;
                "Hours") 
                    if [ $(($temp)) -le 1000 ]; then
                        let temp="$(($temp)) * 3600"
                    else
                        echo "The number you have entered was too high..."
                        continue
                    fi
                    ;;
                "Minutes") 
                    if [ $(($temp)) -le 1000 ]; then
                        let temp="$(($temp)) * 60"
                    else
                        echo "The number you have entered was too high..."
                        continue
                    fi
                    ;;
            esac
            break;
        fi
    done 
}
#--------------------------------------------------------------------
re='^[0-9]*$'
progression=()
test_switch=0

while [ $# -gt 0 ];
do
    if [ "$1" == "--test" ]; then 
        test_switch=1
    fi
    shift
done
#--------------------------------------------------------------------
if [ $test_switch == 0 ]; then
    echo "Thanks for using rm_backup~!"
    echo "Please enter how long would you like your files to persist for. Please"
    echo "- enter the following input values in how many you would like, and do"
    echo "- not use decimal numbers. For the month input, I will consider a month"
    echo "- to be 30 days."
    # Get the time duration on how long the user wants the files to persist.
    get_numbers "Months"
    months=$temp

    get_numbers "Weeks"
    weeks=$temp

    get_numbers "Days"
    days=$temp

    get_numbers "Hours"
    hours=$temp

    get_numbers "Minutes"
    minutes=$temp
else
    let months="0 * 30 * 24 * 3600"
    let weeks="0 * 7 * 24 * 3600"
    let days="0 * 24 * 3600"
    let hours="0 * 3600"
    let minutes="1 * 60"
fi

let total_seconds="$(($months))+$(($weeks))+$(($days))+$(($hours))+$(($minutes))"
#--------------------------------------------------------------------
# Create a copy of the rm_alias file to not ruin the original copy.
touch copy_alias
cat rm_alias.sh >> copy_alias

# Find the location in the rm alias file and replace it with the total seconds.
sed -i -e 's/TOTAL-TIME/'$total_seconds'/g' copy_alias

# Put the correct stat arguments in the file.
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sed -i -e 's/ARGUMENTS/-c %Y/g' copy_alias
elif [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i -e 's/ARGUMENTS/-f %m/g' copy_alias
    cat copy_alias
else
    echo "ERROR: Can't tell what OS you have..."
    if [ -f copy_alias ]; then /bin/rm copy_alias; fi
    if [ -f copy_alias-e ]; then /bin/rm copy_alias-e; fi
    exit 1
fi

if [ ! -d $HOME/.rm_backup/ ]; then mkdir $HOME/.rm_backup/; fi
if [ ! -d $HOME/.rm_backup/script ]; then mkdir $HOME/.rm_backup/script; fi
if [ ! -d $HOME/.rm_backup/backup ]; then mkdir $HOME/.rm_backup/backup; fi

occurences=$(grep -o "rm ()" $HOME/.bashrc | wc -l)
if [ $occurences == 0 ]; then
    if [ $test_switch == 0 ]; then
        if [[ "$OSTYPE" == "linux-gnu" ]]; then
            echo "rm () { bash $HOME/.rm_backup/script/rm_alias.sh \$@ ; }" >> $HOME/.bashrc
            echo "You need to source $HOME/.bashrc"
        elif [[ "$OSTYPE" == "darwin"* ]]; then 
            echo "rm () { bash $HOME/.rm_backup/script/rm_alias.sh \$@ ; }" >> $HOME/.bash_profile
            echo "You need to source $HOME/.bash_profile"
        else 
            echo "You are using a operating system that is not supported."
            exit 1
        fi
    fi
elif [ $occurences == 1 ]; then
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

if [ -f $HOME/.rm_backup/script/rm_alias.sh ]; then /bin/rm $HOME/.rm_backup/script/rm_alias.sh; fi
cat copy_alias >> $HOME/.rm_backup/script/rm_alias.sh
chmod 775 $HOME/.rm_backup/script/rm_alias.sh

#--------------------------------------------------------------------
# Delete the backup copy of the file.
if [ -f copy_alias ]; then /bin/rm copy_alias; fi
if [ -f copy_alias-e ]; then /bin/rm copy_alias-e; fi