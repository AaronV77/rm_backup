#---------------------------------------------------------------------------------------------------------
# This simple function will check to see if the item being backed up is in the .rm_backup directory
# - and if so then removes it from the folder else do nothing. If there are performance issues then
# - this will be the first thing to go because there are other solutions that I could use.
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
#---------------------------------------------------------------------------------------------------------
# This simple function will output all the information need when the argument --help has been issued. If the 
# - help argument has been issued and the user is trying to do anything else then, the system will exit without
# - doing anything else.
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
#---------------------------------------------------------------------------------------------------------
# The following variables are declared for the system and here is a list of what they mean / do:
    # debug_switch: Tells the system to echo helpful print statments.
    # backup_array: Will hold all the items in the .rm_backup directory.
    # folder_removal: Tells the system if the user is trying to delete a folder or not.
    # total_duration: Will tell the system how long a file / folder should persist for.
    # current_time: Will store the current time that the script is ran.
debug_switch=0
backup_array=()
incoming_input_array=()
folder_removal=0
total_duration=3600
VERSION="1.0.6"
current_time=$(date "+%s")
system_home="$HOME/.rm_backup/backup"
#---------------------------------------------------------------------------------------------------------
# This block of code will get the number of incoming arguments and check the last one to see if the
# - debugging flag has been given. If it is then turn on the debugging flag.
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
#---------------------------------------------------------------------------------------------------------    
# This block of code will check to see if the .rm_backup folder is existing. If it is not then it will
# - go and create the folder, or it will loop through the folder looking at all the files and delete
# - any file / folder that is past the persisting time. I also make sure not to delete the following 
# - items '.' or "..".
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
#---------------------------------------------------------------------------------------------------------
# This block of code will loop through the incoming arguments. The first couple of checks that I make will
# - will look for the "-r" and "-rf" command for folder removal. If I find it then I set a flag for the system
# - to make sure to delete the folder and if I don't find it then the system will not delete any directory 
# - is passed in. The next argument that I check is the error flag for debugging purposes. The next part is 
# - the hard part about this system to support. So, I get the number of stars for the given argument, then
# - check to see how many were found. If there was one found I make sure that the star is at the end of the 
# - argument, if not then error out. Next, I check to see if there were two stars, if they are not at the end
# - of the argument then error out. Lastly, I check to make sure that there are not more than two stars, if so 
# - error out. The last part of this code checks to make sure if were looking at a file or directory. If a
# - directory then make sure that we got the proper parameters. Then I make sure to see if the same file or 
# - directory is in the .rm_backup and if it is then remove it so that the update version can be moved in.
# - This is the basic overview of this section of code.
for i in "${incoming_input_array[@]}"
do
    if [ $debug_switch -eq 1 ]; then echo "Looking at: $i"; fi
    if [ "$i" == "-rf" ] || [ "$i" == "-r" ]; then folder_removal=1; shift; continue; fi

    len=$(echo "$i" | tr -cd '*' | wc -c)
    if [ $len -eq 1 ]; then
        # If there is one star found then its not in correct spot.
        if [ "$i" != ""* ]; then
            if [ $debug_switch -eq 1 ]; then echo "There are two reasons as to why the following doesn't work..."; fi
            if [ $debug_switch -eq 1 ]; then echo "The directory that you entered is incorrect or This command is hard to support so don't use it..."; fi
            echo "The argument: $i has an error, use the -error argument."
            exit
        fi
    elif [ $len -eq 2 ]; then
        # If there is two stars found then its not in the correct spot.
        if [ "$i" != ""**]; then
            if [ $debug_switch -eq 1 ]; then echo "You have the stars in the incorrect places dude..."; fi
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