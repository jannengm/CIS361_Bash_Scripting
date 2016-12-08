#! /bin/bash
#*******************************************************************************
#CIS 361 - Project 3: Bash Script Programs
#Part 1b
#@author Mark Jannenga
#
#This program is the second of three programs used together in a pipelin to
#generate a Key Word In Context file. This program prints all lines from the
#input file that do not begin with a word contained in the file specified by
#comnnad line arguments.
#*******************************************************************************

#Prints the passed line of input only if it does not start with a word in the
#specified file
checkLine(){
	#Check the file for the first word on the line
	noiseFound=false
	while read line; do
		if [[ "$line" = "$2" ]]; then
			let noiseFound=true
		fi
	done < $1

	#Print the line only if not found above
	if [ "$noiseFound" = false ]; then
		echo ${*:2}
	fi
}

#Check for command line arguments
if [[ "$#" -lt 1 ]]; then
	echo "Error in $0: Missing command line arguments" 1>&2
	# echo "$0 exited with code 1" 1>&2
	exit 1
fi

#Check that input file exists
if [ ! -e "$1" ]; then
	echo "Error in $0: $1 does not exist" 1>&2
	exit 2
fi

#Check that input file is a regular file
if [ ! -f "$1" ]; then
	echo "Error in $0: $1 is not a regular file" 1>&2
	exit 3
fi

#Check the input file is readable
if [ ! -r "$1" ]; then
	echo "Error in $0: $1 is not readable" 1>&2
	exit 4
fi

#Loop through each line of piped input
firstLine=true
while read line; do
	#Don't process the first line (initial input file name)
	if [ "$firstLine" = true ]; then
		echo $line
		let firstLine=false
	else
		checkLine $1 $line
	fi
done
