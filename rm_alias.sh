#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: July 11th, 2019
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to be able to 
# remove any artifact of the rm_backup application. 
#--------------------------------------------------------------------
# This simple function will check to see if the item being backed up 
# - is in the .rm_backup directory and if so then remove it from the 
# - folder, else do nothing and move on. 
is_in_backup() {
    incoming_arg=$(echo "${1%/}")
    if [ $debug_switch -eq 1 ]; then echo "Searching..."; fi
    for item in "${backup_array[@]}"; do
        if [ $debug_switch -eq 1 ]; then echo "The backup look at: $item and $incoming_arg"; fi
        if [ "$item" == "$incoming_arg" ]; then
            if [ $debug_switch -eq 1 ]; then echo "Found..."; fi
            /bin/rm -rf $system_home/$item
        fi
    done
}
#--------------------------------------------------------------------
# This simple function will output all the information needed when the 
# - argument "--help" has been issued. If the help argument has been 
# - issued and the user is trying to do anything else then, the system 
# - will exit without doing anything else.
help() {
    echo "Welcome to the rm_backup utility! If you are confused as to why you are seeing this, it is due"
    echo "- someone installing the rm_backup utility. This program overrides the rm command, to be able to"
    echo "- uninstall this utility, remove the alias either in your .bashrc or .bash_profile. This utility"
    echo "- will give a user a second chance to save your files / directories. For more information please"
    echo "- go to the following: https://github.com/AaronV77/rm_backup"
    echo ""
    echo "Following arguments for this utility:"
    echo "--dump:       Will delete everything in the .rm_backup directory."
    echo "--verbose:    Will turn on the debugger and output helpful print statments."
    echo "--help:       Will display this helpful message."
    echo "--version:    Will output the current version of this utility."
    echo ""
    echo "Acceptable input for this utility:"
    echo "- rm file"
    echo "- rm file-1 file-2 ..."
    echo "- rm -r folder"
    echo "- rm -r folder-1 folder-2 ..."
    echo "- rm -rf folder"
    echo "- rm -rf folder-1 folder-2 ..."
    echo "- rm *"
    echo "- rm -rf *"
    echo "- rm * /path/to/folder/*"
    echo "- rm -rf * /path/to/folder/*"
    echo "Note: There is support for a forward slash at the end of a directory."
} 
#--------------------------------------------------------------------
# The following variables are declared for the system and here is a list 
# - of what they mean / do:
    # debug_switch: Tells the system to echo helpful print statments.
    # backup_array: Will hold all the items in the .rm_backup directory.
    # folder_removal: Tells the system if the user is trying to delete a folder or not.
    # total_duration: Will tell the system how long a file / folder should persist for.
    # VERSION: Will output the current version for the system.
    # current_time: Will store the current time that the script is ran.
    # system_home: Will store the backup path for all files and folders to be backed up too.
# In the last section of the code I loop through the incoming arguments
# - from the user and execute any if given. 
debug_switch=0
backup_array=()
incoming_input_array=()
folder_removal=0
total_duration=3600
VERSION="1.0.0"
current_time=$(date "+%s")
system_home="$HOME/.rm_backup/backup"

while [ $# -gt 0 ];
do
    if [ "$1" == "--verbose" ]; then 
        debug_switch=1;
    elif [ "$1" == "--help" ]; then 
        help
        exit
    elif [ "$1" == "--dump" ]; then 
        /bin/rm -rf $system_home
        exit
    elif [ "$1" == "--version" ]; then
        echo "Version: $VERSION"
        echo "Written by Aaron Valoroso"
        exit
    else
        incoming_input_array+=("$1")
    fi
    shift
done
#--------------------------------------------------------------------
# This block of code will check to see if the .rm_backup folder existence
# - and if it isn't available then the system will create it and the 
# - backup folder. Next, I check to make sure if the backup directory
# - existence and create it, if it doesn't exist. Lastly, if all the
# - directories do exist, I will loop through the backup directory,
# - stat all the files, ignoring the '.' and '..', and checking to make
# - sure that the modification time has exceeded the persistence time.
# - If it has then I will delete the item, else the system will move on.
if [ ! -d $HOME/.rm_backup ]; then
    mkdir $HOME/.rm_backup/backup
elif [ ! -d $HOME/.rm_backup/backup ]; then
    mkdir $HOME/.rm_backup/backup
else
    if [ "$(find "$system_home" -mindepth 1 -print -quit 2>/dev/null)" ]; then
        if [ $debug_switch -eq 1 ]; then echo "Looping through the rm_backup directory..."; fi
        pwd=$(pwd)
        cd $system_home
        for file in {.,}*
        do  
            file_time=$(stat -c %Y "$file")
            if [ "$file" != '.' ] && [ "$file" != ".." ]; then
                if [ $(($file_time + $total_duration)) -lt $(($current_time)) ]; then
                    if [ $debug_switch -eq 1 ]; then echo "Deleteing the following: $file"; fi
                    if [ -d "$file" ]; then /bin/rm -rf "$file"; else /bin/rm "$file"; fi
                else
                    backup_array+=($file)
                fi
            fi
        done
        cd $pwd
    fi
fi
#--------------------------------------------------------------------
# This block of code will loop through the incoming arguments. The first 
# - couple of checks that I make will will look for the "-r" and "-rf" 
# - command for folder removal. If I they are found, then I set a flag 
# - for the system to make sure to delete the folder and if they are not 
# - found, then the system will not delete any directory that is passed in. 
# - Next, the system is looking for stars. As the system loops through each
# - section of input, it will search for stars. If the algorithm finds a
# - star and it isn't at the end of the section, then error, if it finds
# - two stars and they are not at the end then error, and any more stars then
# - two, then error. Next, I check to see what is being deleted, and make
# - sure that the proper arguments have been given. Next, I touch the file,
# - to change the modification time, see if it is in the backup (if so, delete
# - the backup), and then move the item to the backup.
for i in "${incoming_input_array[@]}"
do
    if [ $debug_switch -eq 1 ]; then echo "Looking at: $i"; fi
    if [ "$i" == "-rf" ] || [ "$i" == "-r" ]; then folder_removal=1; shift; continue; fi

    len=$(echo "$i" | tr -cd '*' | wc -c)
    if [ $len -eq 1 ]; then
        # If there is one star found then its not in correct spot.
        if [ "${i: -1}" != "*" ]; then
            if [ $debug_switch -eq 1 ]; then echo "There are two reasons as to why the following doesn't work..."; fi
            if [ $debug_switch -eq 1 ]; then echo " 1. The directory that you entered is incorrect."; fi
            if [ $debug_switch -eq 1 ]; then echo " 2. The command is not supported and an issue needs to be filed."; fi
            echo "The argument: $i has an error."
            exit
        fi
    elif [ $len -eq 2 ]; then
        # If there is two stars found then its not in the correct spot.
        if [ "${i: -2}" != "**"]; then
            if [ $debug_switch -eq 1 ]; then echo "The stars are in the incorrect places..."; fi
            echo "The argument: $i is incorrect."
            exit
        fi
    elif [ $len -ge 2 ]; then
        if [ $debug_switch -eq 1 ]; then echo "There are to many stars in the given argument..."; fi
        echo "The argument: $i is incorrect."
        exit
    fi

    if [ $debug_switch -eq 1 ]; then echo "Processing: $i"; fi

    if [ -d "$i" ]; then
        if [ $folder_removal -eq 1 ]; then 
            touch "$i"
            if [ $debug_switch -eq 1 ]; then echo "Backing up the following item: $i"; fi
            is_in_backup "$i"
            mv "$i" $system_home
        else
            echo "Can't delete the following: $i, because its a directory."
        fi
    elif [ -f "$i" ]; then
        touch "$i"
        if [ $debug_switch -eq 1 ]; then echo "Backing up the following item: $i"; fi
        is_in_backup "$i"
        mv "$i" $system_home
    else
        echo "Can't delete the following: $i, because its nonexistent."
    fi
    shift
done
#---------------------------------------------------------------------------------------------------------