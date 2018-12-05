#!/bin/bash

in_file=input

polymer=$(cat $in_file)

# 1000 iteration is enough :)
for i in {1..1000}; do
    for x in {a..z}; do
        polymer=${polymer//$x${x^^}}
        polymer=${polymer//${x^^}$x}
    done
done

echo -n $polymer | wc -m
echo ${#polymer}
