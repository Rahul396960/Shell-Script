#!/bin/bash

read -r -p "enter the segment(like if seg is 10.10.10.1, then enter 10.10.10):" seg

n=({1..255})

if [[ $seg =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    for hostip in "${n[@]}";do
        if ! ping -c 1 -W 1 "$seg.$hostip" &> /dev/null;then
            echo "$seg.$hostip => unreachable"
        fi
    done
else

    echo "invalid entry"
fi
