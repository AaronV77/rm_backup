# rm_backup

Thank you for stopping by to take the time to read the README of this repository. This package will hopefully ease a lot of stress on your shoulders if you are using a terminal very often and save a lot of unsaved work that may accidently get deleted through the use of the rm command. The rm_backup repo will setup a rm bash alias that will overshadow the original rm terminal command. In the rm_backup setup script, you will be asked how long you will want your files / directories to persist for. Then every time you issue the rm command the system will loop through the directory and delete any file / directory that has persisted past their life expectency. When the rm bash alias is used the system will create a .rm_backup directiory in your home directory, and this will be where everything that gets deleted by the rm bash alias. 

I am using the terminal almost everyday of my life but there are times that I accidently delete a directory or file by mistake and then on some days my whole home directory. So, the over arching concept of this alias is to give me a second chance to save my files before they get deleted permanetly. Lastly, I am no daily scripter but I'm getting there~! If you see anything that could be done differently, then by all means I'll take any comments or PR's. Thanks.


## Getting Started

Just follow the upcoming sections they should make startup very clear.

## Warnings

Since these are bash scripts, please make sure to always check any scripts that you are going to run on your system! A performance issue that I see with this system is if you have a long life span on your files / directories. The system will have to loop through a massive directory (not recursively) to check each items modification date. A reminder that this is bash alias is overriding the rm command, so if an issue aries with the program just run the origin rm command like such /bin/rm. Lastly, this is overshadowing the rm command and this alias does not support everything that the rm command does "yet", so keep that in mind.

## Prerequisites

The only prerequisites is that you need to use the Bash shell on your system in order to be able to use the script and alias. I have not supported the other shells yet and have only gotten this package to work with Bash. This application works on both Linux and Mac machines seemlessly "I hope lol". 

## Installing

Just run the setup.sh script in the package directory. This script is pretty straight forward.

## Contributing

Like I've said in the previous sections I hope that people get to use these scripts and contribute. Before submitting a PR, I've written a script call credential scan to remove any credentials that you could be stored in the scripts. There is a specific thing that the script is looking for so don't go stashing your IP address or Username anywhere else than needed. This will save a lot of hassel.. trust me, so run the script. 

## Support

Here is a list of the following rm commands that this alias supports and anything else will be considered undefined behavior.
- rm file
- rm file-1 file-2 ...
- rm -r folder
- rm -r folder-1 folder-2 ...
- rm -rf folder
- rm -rf folder-1 folder-2 ...
- rm *
- rm -rf *
- rm * /path/to/folder/*
- rm -rf * /path/to/folder/*

If you want the equivalent of the -v option with the normal rm command, then just add the "-error" option at the end of the input. If the "-error" option is not at the end then the debug statments will not print out. 

# Author: Aaron A. Valoroso

## Inspiring Quotes

“When you don't create things, you become defined by your tastes rather than ability. Your tastes only narrow & exclude people. So create.” 
 - Why The Lucky Stiff

