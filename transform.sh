#!/bin/bash

temp=(This is a text)
STRING="I'm sexy and I know it."
TEMP=Pokemon

#2
echo ${#temp[1]}

#4
echo ${#temp}

#2
i=${STRING//[^I]/}
echo ${#i}

#6
i=${STRING:0:6}
echo ${#i}

#sexy
echo ${STRING:4:4}

#know
echo ${STRING:15:4}

#pokemon
echo ${TEMP,}

#.
echo ${STRING:${#STRING}-1}

#I'm
echo ${STRING%% *}

#POKEMON
echo ${TEMP^^}
