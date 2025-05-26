#!/bin/bash

if [[ $# != 2 ]];
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

if [[ ! -d $1 ]] || [[ ! -d $2 ]];
then
  echo "Invalid directory path provided"
  exit
fi

targetDirectory=$1
destinationDirectory=$2

currentTS=`date +%s`

backupFileName="backup-$currentTS.tar.gz"

origAbsPath=`pwd`

cd $destinationDirectory
destDirAbsPath=`pwd`

cd $origAbsPath
cd $targetDirectory


yesterdayTS=$(($currentTS - 24*60*60))

RecentlyModifiedFileCount=$(find . -type f -newermt "@$yesterdayTS" | wc -l)

if [[ $RecentlyModifiedFileCount -gt 0 ]];
then
  tar -czvf "$backupFileName" "."

  mv -iv $backupFileName $destDirAbsPath
else
  echo "No file modified"
fi