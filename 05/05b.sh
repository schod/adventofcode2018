#!/bin/bash

in_file=input

polymer=$(cat $in_file)
min_size=${#polymer}

for ch in  {a..z}; do
    test_polymer=${polymer//$ch}
    test_polymer=${test_polymer//${ch^^}}

    # 2000 iteration is enough :)
    for i in {1..2000}; do
        for x in {a..z}; do
            test_polymer=${test_polymer//$x${x^^}}
            test_polymer=${test_polymer//${x^^}$x}
        done
    done

    if [ ${#test_polymer} -lt $min_size ]; then
        min_size=${#test_polymer}
    fi
done

echo $min_size
