#--------------------------------------------------------------------
#Author: Aaron Anthony Valoroso
#Date: July 11th, 2019
#License: GNU GENERAL PUBLIC LICENSE
#Email: valoroso99@gmail.com
#--------------------------------------------------------------------
# General File Overview: The mission for this file is to check to make
# sure that the current shell being used to run the tests is BASH. If
# not then none of the other tests will try to run.
#--------------------------------------------------------------------
current_shell=$(echo $SHELL)
if [ "$current_shell" != "/bin/bash" ]; then
    echo "The current build is not working with the Bash Shell."
    exit 1
fi