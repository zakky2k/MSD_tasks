#!/bin/bash
# Script to move files from source to destination folder.
# Copied files are checksum-validated against thier originals.
# Any file having passed checksum validation would be deleted from the source folder, any file that failed would not be deleted.
# Files are copied using Rsync with --ignore exisitng option to ensure no file in target folder gets overwritten
###################
# Date: 2022-01-29
# Author: Zak Foreman
##################
# Assign log filename based on home folder
export LOGFILE=$HOME"/transferLog_$(date +"%Y%m%dT%H%M%S")"

# Initiate log file
echo "$(date +"%F_%T") Process Starting - checking env. variables" > $LOGFILE

# Test if $SOURCE and $TARGET already declared 
if [ x"${SOURCE}" == "x" ] || [ x"${TARGET}" == "x" ]; then 
     echo "$(date +"%F_%T") Source / Target  not assigned to a Env. variables" >> $LOGFILE
  else
     echo "$(date +"%F_%T") Values assigned to Source / Target variables" >> $LOGFILE
  fi

# Test if declared directories existing
if [ ! -d "$SOURCE" ] || [ ! -d "$TARGET" ]; then 
    echo "$(date +"%F_%T") FATAL: $SOURCE or $TARGET directories do not exist" >> $LOGFILE && exit 100

# Create checksum list of source files
echo "$(date +"%F_%T") Storing checksum of source files into $SOURCE/SourcefilesChecksum.sha1 :" >> $LOGFILE
cd $SOURCE
sha1sum * > ./SourcefilesChecksum.sha1

# Copy files, ignore existing (including checksum file for later validation)
echo "$(date +"%F_%T") Rsync Files - Start" >> $LOGFILE
rsync -a -v --ignore-existing $SOURCE/ $TARGET/ >> $LOGFILE
echo "$(date +"%F_%T") Rsync Files - End" >> $LOGFILE

# Checksum test to log entries 
echo "$(date +"%F_%T") validating Checksum"
cd $TARGET
sha1sum -c ./SourcefilesChecksum.sha1  >> $LOGFILE

# Checksum test and delete source files
#sha1sum -c ./SourcefilesChecksum.sha1 | grep -v "FAILED" | grep "OK" | cut -d ':' -f1 | rm   >> $LOGFILE
deleteArray=(sha1sum -c ./SourcefilesChecksum.sha1 | grep -v "FAILED" | grep "OK" | cut -d ':' -f1)
cd $SOURCE
for i in "${deleteArray[@]}"
do
	echo "$(date +"%F_%T") Deleting source file $1" >> $LOGFILE
	rm $i 
done

exit 0
