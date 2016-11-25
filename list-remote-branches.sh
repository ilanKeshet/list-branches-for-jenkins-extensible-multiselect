#!/bin/bash


# replace with your own repo 
REPO=https://github.com/ilanKeshet/list-branches-for-jenkins-extensible-multiselect.git

# list remote branches - and take only the part local part
LIST=$(/usr/local/bin/git ls-remote -h $REPO\
 | /bin/awk '{print $2}'\
 | /bin/sed s%^refs/heads/%%)

#LIST=

# target file - the script assumes that all directories in path exist 
B_FILE="/var/lib/jenkins/git-branch-list-populator/branches.txt"

if [ -z "$LIST" ] ; then
    # if LIST is empty - dont clear the exiting target file
    if [ -z "$(/bin/grep 'could not fetch branches' $B_FILE)" ] ; then
        # att a message at the top of the list in the targert file
        PREV=$(/bin/cat $B_FILE)
        /bin/sed -i 's|MDLP=|MDLP=could not fetch branches,|' $B_FILE
    fi
else
    RE_GEX="[0-9]?\.[0-9]?\.?|master"

    # resets the list - feature branches get to be on top
    RES1=$(/bin/echo "$LIST" | /bin/grep -v -E "$RE_GEX" | LC_COLLATE=C /bin/sort -f -r)

    # version branches get to be on the bottom
    RES2=$(/bin/echo "$LIST" | /bin/grep -E "$RE_GEX" | /bin/sort -f)

    # puting it all together
    RES=$(/bin/echo -e "MDLP=$RES1\n$RES2" | /usr/bin/tr '\n' ',')

    # writing to the file
    /bin/echo "$RES" > $B_FILE
fi
