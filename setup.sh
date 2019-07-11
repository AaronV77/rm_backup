#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: July 11th, 2019
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to setup the rm_backup
# application on any given Linux / Unix flavor system. 
#--------------------------------------------------------------------
# This function will be used to clean up the system if the user needs to
# - exit the script at any point. The copy_alias is what the system will
# - as its place holder for copying the script template in the main directory
# - and injecting the couple lines of code that will support portability.  
# - The trap feature is what will be used to catch the certain signals that
# - the user may use at any point during the script executing.
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
# This function is used to grab user input and make sure that numbers are
# - are the only thing that is being entered, if not then the system will
# - ask again. Once you enter a valid number into the system, the system
# - will take the number in for each section and calculate the persistance
# - time for each section. Once all sections have been calculated, the total
# - persistance time will be calculated.
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
# In this section of code I setup certain variables that will be used
# - throughout the script and checking incoming input with the execution
# - of the script.. The variable re is used for checking input for 
# - numbers and a test switch statment. The check for input will only
# - take in the "--test" argument, and this argument will tell the system
# - to setup the system for testing purposes.
re='^[0-9]*$'
test_switch=0

while [ $# -gt 0 ];
do
    if [ "$1" == "--test" ]; then 
        test_switch=1
    fi
    shift
done
#--------------------------------------------------------------------
# In this section of code I will either ask the user for input for how
# - long they want their files and folders to persist for, but if we are 
# - just testing the system then we will setup the persistance time 
# - manually. I put the heading in this section because it is not needed
# - for printing out in tests. Lastly, at the very bottom we will calculate 
# - the total persistence time.
if [ $test_switch == 0 ]; then
    echo "Thanks for using rm_backup~!"
    echo "Please enter how long would you like your files to persist for. Please"
    echo "- enter the following input values in how many you would like, and do"
    echo "- not use decimal numbers. For the month input, I will consider a month"
    echo "- to be 30 days."
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
# In this section of code I will copy the rm_alias script (template) and 
# - create a new copy for updating certain values. I replace one of the values
# - "TOTAL-TIME" with the persistance time of every file and folder. Next,
# - I check to see what operating system is being used and will update the
# - stat command based of of the OS that is being used. I use the "Arguments"
# - key word for the stat command. Any other OS will cause the system to 
# - error out. Lastly, I create the new home of our copy and a home for all 
# - of the deleted files and folders to be stored in. 
touch copy_alias
cat rm_alias.sh >> copy_alias

sed -i -e 's/TOTAL-TIME/'$total_seconds'/g' copy_alias

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sed -i -e 's/ARGUMENTS/-c %Y/g' copy_alias
elif [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i -e 's/ARGUMENTS/-f %m/g' copy_alias
else
    echo "ERROR: Can't tell what OS you have..."
    if [ -f copy_alias ]; then /bin/rm copy_alias; fi
    if [ -f copy_alias-e ]; then /bin/rm copy_alias-e; fi
    exit 1
fi

if [ ! -d $HOME/.rm_backup/ ]; then mkdir $HOME/.rm_backup/; fi
if [ ! -d $HOME/.rm_backup/script ]; then mkdir $HOME/.rm_backup/script; fi
if [ ! -d $HOME/.rm_backup/backup ]; then mkdir $HOME/.rm_backup/backup; fi
#--------------------------------------------------------------------
# In this section of code I am looking for any past rm () aliases in the 
# - specified OS and shell type. If we are running tests then there is no
# - need to setup the .bashrc or .bash_profile, because I will be running
# - the script with any given arguments. If we are not running tests, then
# - I check to see if there are no occurences of the alias in either file,
# - if there is none then I can just add the alias to the bottom of the file,
# - if there is one, I can just remove it from the file and add to the new
# - one to the bottom of the file, and lastly if there are more than one,
# - then the user needs to clean up either file being used. Lastly, I check
# - to see if there is a rm_alias script in the script directory, if so just
# - delete it  and  movet he new script into its position with the correct
# - permissions. I then delete the copy file for the rm script.
occurences=$(grep -o "rm ()" $HOME/.bashrc | wc -l)
if [ $test_switch == 0 ]; then
    if [ $occurences == 0 ]; then
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
fi

if [ -f $HOME/.rm_backup/script/rm_alias.sh ]; then /bin/rm $HOME/.rm_backup/script/rm_alias.sh; fi
cat copy_alias >> $HOME/.rm_backup/script/rm_alias.sh
chmod 775 $HOME/.rm_backup/script/rm_alias.sh

if [ -f copy_alias ]; then /bin/rm copy_alias; fi
if [ -f copy_alias-e ]; then /bin/rm copy_alias-e; fi
#--------------------------------------------------------------------