# rm_backup

&nbsp;Linux / Mac  
[![Build Status](https://travis-ci.org/AaronV77/rm_backup.svg?branch=master)](https://travis-ci.org/AaronV77/rm_backup)

Thank you for stopping by to take the time to read the README of this repository. This package will hopefully ease a lot of stress on your shoulders if you are using a terminal everyday and save a lot of unsaved work that may accidently get deleted through the use of the rm command. The rm_backup repo will setup a rm bash alias that will overshadow the original rm terminal command. In the rm_backup setup script, you will be asked how long you will want your files / directories to persist for. Then every time you issue the rm command, the system will loop through the directory and delete any file / directory that has persisted past their life expectency. On the application setup, the system will create a .rm_backup in your $HOME directtory and have two folders stored inside. The "backup" directory is where all deleted items will be stored, and the "script" directory will store the bash script for the application. 

I am using the terminal almost everyday of my life but there are times that I accidently delete a directory or file by mistake and then on some days my whole home directory. So, the over arching concept of this alias is to give me a second chance to save my files before they get deleted permanetly. Lastly, I have not optimized the application yet, but I have just finished the core test scripts to help with the accuracy of the project. If you see anything that could be done differently or optimized, then by all means I'll take any comments or PR's. Thanks.


## Getting Started

The following sections will get you up and running, and on your way.

## Warnings

A couple of warnings just to be helpful:
- Please always check any type of shell script before running it on your system. Awarness is key.
- There is a performance issue that can arise with this utility if you allow your files / folders to persist for a long time... The backup will get full and it will take the system a bit of time to churn through all the items in the backup to check each items life span. This is not a recursive churn but still.
- This Bash alias is overriding the rm command, so if an issue aries with the program, just run the origin rm command like such /bin/rm. You can remove the system by hand (In the .bashrc / .bash_profile and .rm_backup) or just run the tear_down.sh script. Please report any issues that you are facing so that we can get it fixed.
- Do not try to delete anything in the backup using the rm utility, just use the /bin/rm command. This is not supported.
- Lastly, this is overshadowing the rm command and this alias does not support everything that the rm command does "yet", so keep that in mind.

## Prerequisites

The simplicity of this project is that all you need is to be using some type of Linux / Unix operating system and to be using the terminal. The only prerequisites is that you need to use the Bash shell on your system in order to be able to use the script and alias. I have not supported the other shells yet and have only gotten this package to work with Bash. This application works on both Linux and Mac machines. 

## Installing

Just run the setup.sh script in the package directory and if you want to remove the package just run the tear_down.sh script. Both of these Bash scripts should be straight forward and if not then please read through the comments.

## Contributing

Like I've said in the previous sections I hope that people get to use these scripts and contribute. If there are issues then please let me know so that I can make the proper adjustments or if you think you have a better way then lets chat! 

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
- rm filename*
- rm *.txt

Note: There is support for a forward slash at the end of a directory.

Here is a list of the arguments that can be used with the rm_alias:
- --help:       Will display this helpful message.
- --verbose:    Will turn on the debugger and output helpful print statments.
- --dump:       Will delete everything in the .rm_backup directory.
- --version:    Will output the current version of this utility.


# Author: Aaron A. Valoroso

## Inspiring Quotes

“When you don't create things, you become defined by your tastes rather than ability. Your tastes only narrow & exclude people. So create.” 
 - Why The Lucky Stiff

