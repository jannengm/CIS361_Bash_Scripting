#! /bin/bash
#*******************************************************************************
#*******************************************************************************

#Prompt user for name of the data directory
echo -n "Enter directory name: "
read dataDirectory

#Check zip archive provided as command line argument
# if test $# -eq 1
# 	then
# 		echo "Must provide an argument"
# fi

#Check if that directory exists
if test ! -d $dataDirectory
	then
		mkdir $dataDirectory
fi

#Unzip .zip archive into specified data directory
unzip -q $1 -d $dataDirectory

# Loop through each unzipped file
for file in $dataDirectory/*
do
	#Get the username assoociated with each file
	userDirectory=$(echo "$file" | sed 's/_attempt_.*//' | sed 's/.*_//')

	#Create user directory if it doesn't already exists
	if test ! -d $dataDirectory/$userDirectory
		then
			mkdir $dataDirectory/$userDirectory
	fi

	#Get the basename of the file
	filename=$(echo "$file" | sed 's/.*_//')

	#Move file to user directory
	newFile=$dataDirectory/$userDirectory/$filename
	if [[ $newFile =~ .*[0-9]*-[0-9]*-[0-9]*-[0-9]*-[0-9]*-[0-9]*.txt.* ]]
		then
			newFile="$dataDirectory/$userDirectory/memo.txt"
	fi
	mv "$file" "$newFile"
done

# Once all files are extracted, loop through each directory and run tests
touch report
for directory in $dataDirectory/*/
do
	make -f ../../makefile -C $directory >> report
	make test -f ../../makefile -C $directory >> report
done

#Clean up files created in working directory by tests
rm *.out
rm *.bak
