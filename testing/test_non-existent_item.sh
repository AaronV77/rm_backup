rm_output=$(rm something)
if [ "$rm_output" == "" ]; then
    echo "The rm utility did not operate correctly for removing a file that does not exist."
    exit 1
fi