# rm_backup

Thank you for stopping by to take the time to read the README of this package. This package will hopefully ease a lot of stress on your shoulders if you are using a terminal very often and save a lot of unsaved work that may accidently get deleted. The rm_backup package is a bash alias that overshadows the original rm terminal command. This repository has an alias that will create a .rm_backup directory in your home directory. This is where all the files / directories that you try to delete will be stored for a certain amount of time. So, when you remove a directory or item, the alias will loop through the .rm_backup and do some arithmetic to see if the files and directorys that are stored in the directory should be removed. Then, the alias will move the item that you are trying to remove to the .rm_backup directory. I make sure to change the modification time of the item to ensure that it will not get deleted on the next item removal.

I am using the terminal almost everyday of my life but there are times that I accidently delete a directory or file by mistake and then on some days my whole home directory. So, the over arching concept of this alias is to give me a second chance to save my files before they get deleted permanetly. Lastly, I am no daily scripter but I'm getting there~! If you see anything that could be done differently, then by all means I'll take any comments or PR's. Thanks.


## Getting Started

Just follow the upcoming sections they should make startup very clear.

## Warnings

Since these are bash scripts, please make sure to always check any scripts that you are going to run on your system! One word of caution that I would have to mention is that if you are constantly deleteing files then it may be smart to have a short life span on your files so that they are getting removed at a regular rate or this .rm_backup directory will get pretty huge. Lastly, this is overshadowing the rm command and this alias does not support everything that the rm command does "yet", so keep that in mind.

## Prerequisites

The only prerequisites is that you need to use the Bash shell on your system in order to be able to use the script and alias. I have not supported the other shells yet and have only gotten this package to work with Bash.

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


# Author: Aaron A. Valoroso


## Inspiring Quotes

“When you don't create things, you become defined by your tastes rather than ability. Your tastes only narrow & exclude people. So create.” 
 - Why The Lucky Stiff

