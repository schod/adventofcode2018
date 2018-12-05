#!/bin/bash

in_file=input
# in_file=testinput_a

declare -A matrix

while read -r line; do
    # echo $line

    num=$(echo $line|sed 's/#\([0-9]*\) .*/\1/')
    # num="${${X% @*}:1}"
    x=$(echo $line|sed 's/.*@ \([0-9]*\),.*/\1/')
    # x="${${X#*@ }%,*}"
    y=$(echo $line|sed 's/.*,\([0-9]*\):.*/\1/')
    # y="${${X#*,}%:*}"
    x_len=$(echo $line|sed 's/.*: \([0-9]*\)x.*/\1/')
    # x_len="${${X#*: }%x*}"
    y_len=$(echo $line|sed 's/.*x\([0-9]*\)/\1/')
    # y_len="${X#*x}"

    # echo $num $x $y $x_len $y_len

    max_x=$[ $x + $x_len ]
    max_y=$[ $y + $y_len ]

    for ((xx=$x;xx<$max_x;xx++)); do
        for ((yy=$y;yy<$max_y;yy++)); do
            if [ "${matrix[$xx,$yy]}" == "" ]; then
                matrix[$xx,$yy]=$num
            else
                matrix[$xx,$yy]="X"
            fi
        done
    done
done < "$in_file"

echo "--------------------"
# printf '%s\n' "${matrix[@]}" #| grep X | wc -l

while read -r line; do
    # echo $line

    num=$(echo $line|sed 's/#\([0-9]*\) .*/\1/')
    # num="${${X% @*}:1}"
    x=$(echo $line|sed 's/.*@ \([0-9]*\),.*/\1/')
    # x="${${X#*@ }%,*}"
    y=$(echo $line|sed 's/.*,\([0-9]*\):.*/\1/')
    # y="${${X#*,}%:*}"
    x_len=$(echo $line|sed 's/.*: \([0-9]*\)x.*/\1/')
    # x_len="${${X#*: }%x*}"
    y_len=$(echo $line|sed 's/.*x\([0-9]*\)/\1/')
    # y_len="${X#*x}"

    SUM_X=0

    max_x=$[ $x + $x_len ]
    max_y=$[ $y + $y_len ]

    for ((xx=$x;xx<$max_x;xx++)); do
        [ $SUM_X -gt 0 ] && break
        for ((yy=$y;yy<$max_y;yy++)); do
            if [[ "${matrix[$xx,$yy]}" == "X" ]]; then
                SUM_X=1
            fi
        done
    done

    if [ $SUM_X -eq 0 ]; then
        echo $num
        exit 0
    fi
done < "$in_file"
