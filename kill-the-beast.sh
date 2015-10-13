#!/bin/bash

declare -a deck=($(for i in {1..13}; do echo C${i}; done)
                 $(for i in {1..13}; do echo S${i}; done)
                 $(for i in {1..13}; do echo D${i}; done)
                 $(for i in {1..13}; do echo H${i}; done))

declare -a beast_hand
declare player

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

initialize_beast_hand(){
    for i in {1..10}
    do
        index=$(($RANDOM % ${#deck[@]}))
        beast_hand[$index]=${deck[$index]}
        unset deck[$index]
    done
}

initialize_player_hand(){
        index=$(($RANDOM % ${#deck[@]}))
        player=${deck[$index]}
        unset deck[$index]
}

echo ${deck[@]}
initialize_beast_hand
echo ${deck[@]}
initialize_player_hand
echo ${deck[@]}

#while player not dead or not yet done
#
#    if input is quit
#        quit
#
#    if traverse
#        compare player
#        if win next round
#        else dies
#    else if dodge
#        compare player
#        if win next round
#        else change cards


