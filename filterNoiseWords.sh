#! /bin/bash

checkLine(){
	noiseFound=false
	while read line; do
		if [[ "$line" = "$2" ]]; then
			let noiseFound=true
		fi
	done < $1

	if [ "$noiseFound" = false ]; then
		echo ${*:2}
	fi
}

echo $*
while read line; do
	checkLine $1 $line
done
