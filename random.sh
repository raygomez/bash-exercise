#!/bin/bash

for i in {1..5}
    do random[i]=$RANDOM.$RANDOM
done
echo ${random[@]} | sed 's/ /, /g'

