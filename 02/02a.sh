#!/bin/bash

in_file=input

SUM2=0
SUM3=0

while IFS='' read -r line; do
    x2=0
    x2=$( echo "$line" | grep -o . | sort | uniq -c | grep "^[ \t]*2 " | wc -l )
    x3=0
    x3=$( echo "$line" | grep -o . | sort | uniq -c | egrep -v "^[ \t]*1 |^[ \t]*2 " | wc -l )
    
    [ $x2 -gt 0 ] && SUM2=$[ $SUM2 + 1 ]
    [ $x3 -gt 0 ] && SUM3=$[ $SUM3 + 1 ]


done < "$in_file"

echo $[ $SUM2 * $SUM3 ]
