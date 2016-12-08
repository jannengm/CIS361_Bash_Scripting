#! /bin/bash

#Define function to process each line
processLine()
{
	let i=0
	while [[ "$i" -lt "$#" ]]; do
		let j=0
		while [[ "$j" -lt "$#" ]]; do
			let index="($i+$j)%$#+1"
			let j=j+1
			#Remove carriage returns
			word=$(echo ${!index}|tr -d '\r')
			printf '%s ' $word
			# echo ${!index}
		done
		# echo -n -e "\n"
		printf '\n'
		let i=i+1
	done
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

#Loop through each entry in the provided data file
echo $1
while read line; do
	processLine $line
done < $1
