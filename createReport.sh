#! /bin/bash
#*******************************************************************************
#CIS 361 - Project 3: Bash Script Programs
#Part 1c
#@author Mark Jannenga
#
#This program is the third of three programs used together in a pipelin to
#generate a Key Word In Context file. This program removes all duplicate lines,
#orders the input alphabetically, and then outputs it to a specified output
#file.
#*******************************************************************************

#Check for command line arguments
if [[ "$#" -lt 1 ]]; then
	echo "Error in $0: Missing command line arguments" 1>&2
	echo "$0 exited with code 1" 1>&2
	exit 1
fi

#Loop through each piped line of input
firstLine=true
while read line; do
	#Don't process the first line (initial input file name)
	if [ "$firstLine" = true ]; then
		let firstLine=false
		inputFile=$line
	else
		echo $line >> tmp
	fi
done

#If tmp exists (i.e. there was at least one line of piped input)
if [ -e "tmp" ]; then
	#Remove duplicates and sort
	cat tmp | awk '!seen[$0]++' | sort -k1 > $1
	rm tmp

	#Add footer containing number of lines in input and output files
	inSize=$(cat $inputFile | wc -l)
	outSize=$(cat $1 | wc -l)
	echo -e "\nThe number of lines in the input file $inputFile is $inSize" >> $1
	echo "The number of lines in the output file $1 is $outSize" >> $1
fi
