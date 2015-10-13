#!/bin/bash
declare -a deck=($(for i in {1..13}; do echo C${i}; done)
                 $(for i in {1..13}; do echo S${i}; done)
                 $(for i in {1..13}; do echo D${i}; done)
                 $(for i in {1..13}; do echo H${i}; done))

declare -a beast_hand
declare player

TRAVERSE=0
DODGE=1
QUIT=2
mode=-1

get_input(){
    valid=0

    while [ "${valid}" -eq 0 ]
    do
        echo 'Enter input:'
        read input
        case "${input,,}" in
            traverse) mode=TRAVERSE; valid=1;;
            dodge) mode=DODGE; valid=1;;
            quit) mode=QUIT; valid=1;;
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
    for i in {0..9}
    do
        index=$(($RANDOM % ${#deck[@]}))
        beast_hand[${i}]=${deck[${index}]}
        unset deck[${index}]
        deck=(${deck[@]})
    done
}

initialize_player_hand(){

        size=${#deck[@]}
        index=$(($RANDOM % ${size}))
        player=${deck[$index]}
        unset deck[${index}]
        deck=(${deck[@]})
}

round=1
dead=0
fail=0

compare(){

    fail=0
    pdigit="${1//[^0-9]}"
    bdigit="${2//[^0-9]}"
    psuit="${1//[0-9]}"
    bsuit="${2//[0-9]}"

    if [ "${pdigit}" -lt "${bdigit}" ]
    then
        dead=1
    elif [ "${pdigit}" == "${bdigit}" ]
    then
        if [ "${psuit}" == 'H' ]
        then
            echo 'next round'
        elif [ "${psuit}" == 'D' ]
        then
            if [ "${bsuit}" == 'H' ]
            then
                fail=1
            else
                echo 'next round'
            fi
        elif [ "${psuit}" == 'S' ]
        then
            if [ "${bsuit}" == 'C' ]
            then
                echo 'next round'
            else
                fail=1
            fi
        else
            fail=1
        fi
    else
        echo 'next round'
    fi


}
traverse(){
    set -xv

    echo 'Round' $round
    (( index = round - 1 ))
    round_card="${beast_hand[${index}]}"

    echo "Player ${player} vs Beast ${round_card}"
    compare ${player} ${round_card}

    if [ ${fail} -ne 0 ]; then
        dead=1
    fi
    (( round++ ))

    echo 'traverse'
}

initialize_beast_hand
initialize_player_hand

while (( ${dead} == 0 ));
do
    get_input
    if (( ${mode} == ${TRAVERSE} ))
    then
        traverse
    elif (( ${mode} == ${DODGE} ))
    then
        echo "dodge"
    else
        exit 1
    fi
done

