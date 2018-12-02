#!/bin/bash

in_file=input
freq=0

# slow variant
while IFS='' read -r line; do
    freq=$[ $freq $(echo $line|sed 's/\([-+]\)/\1 /') ] 
done < "$in_file"

echo $freq

# OR use bc

x=$(cat $in_file | tr -d '\n')
echo -e 0$x | bc