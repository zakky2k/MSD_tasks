# MSD_tasks
Task1 -  script exercises.
To run script:
1) Create SOURCE and TARGET Env. Variables for folders
export SOURCE=/home/zak/sourced
export TARGET=/home/zak/targetd

2) create / append >> 5 files in source folder
echo 1 >> sourced/1.txt
echo 2 >> sourced/2.txt
echo 3 >> sourced/3.txt
echo 4 >> sourced/4.txt
echo 5 >> sourced/5.txt

3) create / append >> 1 file with same name as a source file but with different data - this will validate that target files not getting overwritten.
echo "This is an existing file 3" >> targetd/3.txt

4) chmod 777 on the script then execute
chmod 777 transfer.sh 

Validation:
1) Source files will be copied to destination folder
2) Existing file in target folder (with unique data) will be preserved
3) checksum used to validate which files transferred succesfully, and only delete those from source folder (i.e. move). 
4) log file generated with relevant details in home folder 
