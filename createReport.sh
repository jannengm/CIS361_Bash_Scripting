#! /bin/bash

while read line; do
	echo $line >> tmp
done

cat tmp | awk '!seen[$0]++' | sort -k1 > $1
rm tmp
