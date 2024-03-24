#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# Declare the variables of the the target and destination directory.
targetDir=$1
destinationDir=$2

# To confirm the path of the directory we can echo to see if the path was correct
echo "target directory is $1"
echo "destination directory is $2"

# we set current time to seconds so that we can later use to check files not backed up in the last 24 hours.
currentTS=$(date +%s)

# declare the file name where compressed and zipped files will be backed up.
backupFileName="backup-$currentTS.tar.gz"

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# Here is the variable of the current directory.
origAbsPath=$(pwd)

# Change directory to the destination where you want to save your backed up file.
cd "$destinationDirectory"
destDirAbsPath=$(pwd)

# change directory to the source directory where the files are located.
cd "$origAbspath"
cd "$targetDirectory"

# Here we compare the files that havent been backed up within the last 24 hours.
yesterdayTS=$(($currentTS - 24 * 60 * 60))

# in the source directory we check all the list using for loop
# if the date of modified file is greater than the last 24 hours its moved to backup file.

declare -a toBackup

for file in $(ls) 
do
  
  if ((`date -r $file +%s` > $yesterdayTS))
  then
    
    toBackup+=($file)
  fi
done

# list of modified files are then archived using tar -cvf command.
#these files are archived and theiir new file name is backupFileName which was declared earlier. 
tar -czvf "$backupFileName" "${toBackup[@]}"

# we are now ready to move or copy the compressed and archived file from the source directory to the destination directory.
mv "$backupFileName" "$destDirAbsPath"

# I hope this code helps if we want to automate the backup so that we don't manually waste time and create bottlenecks:
# we use crontab
# i have attached crontab image of the automation.
