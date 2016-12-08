#! /bin/bash

#Check for command line arguments
if [[ "$#" -lt 1 ]]; then
	echo "Error in $0: Missing command line arguments" 1>&2
	echo "$0 exited with code 1" 1>&2
	exit 1
fi

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

if [ -e "tmp" ]; then
	cat tmp | awk '!seen[$0]++' | sort -k1 > $1
	rm tmp

	inSize=$(cat $inputFile | wc -l)
	outSize=$(cat $1 | wc -l)
	echo -e "\nThe number of lines in the input file $inputFile is $inSize" >> $1
	echo "The number of lines in the output file $1 is $outSize" >> $1
fi
