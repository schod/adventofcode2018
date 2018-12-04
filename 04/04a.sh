#!/bin/bash

in_file=input

sort -o $in_file $in_file

declare -A guard_sleep_max
declare -A guard_histogram

current_guard=""
sleep_start=""

function get_min {
    echo $1 | sed 's/\[.* [0-9]*:\(.*\)\] .*/\1/' | sed 's/^0//'
}

while read -r line; do
    # begins shift 
    if [[ $line == *begins* ]]; then
        current_guard=$(echo $line | sed 's/.*#\([0-9]*\) .*/\1/' )
        if [ "${guard_sleep_max[$current_guard]}" == "" ]; then
            guard_sleep_max[$current_guard]=0
        fi

    # falls asleep
    elif [[ $line == *falls* ]]; then
        sleep_start=$(get_min "$line")
    
    # wakes up
    elif [[ $line == *wakes* ]]; then

        # Sum of sleep
        sleep_duration=$[ $(get_min "$line") - $sleep_start ]
        guard_sleep_max[$current_guard]=$[ ${guard_sleep_max[$current_guard]} + $sleep_duration ]

        # sleep histogram
        sleep_end=$[ $sleep_start + $sleep_duration ]
        for ((i=$sleep_start; i<$sleep_end; i++)); do
            guard_histogram[$current_guard]=${guard_histogram[$current_guard]}"$i,"
        done
    fi

done < "$in_file"

echo "#########################################"
max=0
max_g=0
for i in ${!guard_sleep_max[*]}
do
    if [  ${guard_sleep_max[$i]} -gt $max ]; then
        max=${guard_sleep_max[$i]}
        max_g=$i
    fi
done

h=$(echo ${guard_histogram[$max_g]} | sed 's/,/\n/g'| grep "[0-9]" | sort | uniq -c | sort -n | tail -1 | sed 's/.* //')


echo ""
echo Part 1: "$[ $max_g * $h ]"


echo "#########################################"

max=0
max_g=0
max_h=0

for i in ${!guard_histogram[*]}
do
    x=$(echo ${guard_histogram[$i]} | sed 's/,/\n/g' | sort | uniq -c | sort -n | tail -1)
    
    count=$(echo $x | sed 's/ .*//')
    h=$(echo $x | sed 's/.* //')
    

    if [ $count -gt $max ]; then
        max=$count
        max_g=$i
        max_h=$h
    fi
done

echo ""
echo Part 2: "$[ $max_g * $max_h ]"
