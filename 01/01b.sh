#!/bin/bash

in_file=input
freq=0

echo -n > /tmp/x

# Really slow :(
while true; do
    while IFS='' read -r line; do
        freq=$[ $freq $(echo $line|sed 's/\([-+]\)/\1 /') ] 
        x=$(grep "^$freq$" /tmp/x | wc -l)
        # echo $x
        if [ $x -eq 1 ]; then
            echo $freq
            exit 0
        fi
        echo $freq >> /tmp/x
    done < "$in_file"
done
