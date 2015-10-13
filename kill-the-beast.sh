#!/bin/bash

declare -a deck=($(for i in {1..13}; do echo C${i}; done)
                 $(for i in {1..13}; do echo S${i}; done)
                 $(for i in {1..13}; do echo D${i}; done)
                 $(for i in {1..13}; do echo H${i}; done))

mode=-1
get_input(){
    valid=0

    while [ "${valid}" -eq 0 ]
    do
        echo 'Enter input:'
        read input
        case "${input,,}" in
            traverse) echo "Traverse";valid=1;;
            dodge) echo "Dodge";valid=1;;
            quit) echo "Quit";valid=1;;
        *) echo "Not valid"
        esac
    done
}
get_input
#for i in {1..10}; do
#    get_input
#done

print_card() {
    card=""
    num="${1//[^0-9]}"
    case ${num} in
        1) card='Ace';;
        2|3|4|5|6|7|8|9|10) card="${num}";;
        11) card='Jack';;
        12) card='Queen';;
        13) card='King';;
        *)card="Invalid"
    esac

    card+=" of "
    case "$1" in
        *C)card+='Club';;
        *S)card+="Spades";;
        *D)card+="Diamond";;
        *H)card+="Heart";;
    esac

    echo -e "You get $card."
}



#print_card 10S
#print_card 1S
#print_card 11H
#print_card 12D
#print_card 13C