#! /bin/bash

#Define function to process each line
processLine()
{
	#How many words?
	# echo $*
	# echo "   $# words"
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

#Loop through each entry in the provided data file
while read line; do
	# echo $line
	#Process the line
	processLine $line
done < $1
