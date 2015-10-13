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
    for i in {1..10}
    do
        index=$(($RANDOM % ${#deck[@]}))
        beast_hand[${i}]=${deck[${index}]}
        unset deck[${index}]
    done


}

initialize_player_hand(){
        index=$(($RANDOM % ${#deck[@]}))
        player=${deck[$index]}
        unset deck[${index}]
}

round=1
dead=0

traverse(){

    round_card="${beast_hand[${round}]}"
    echo "round" ${round}
    echo "card" "${beast_hand[${round}]}"

    echo ${round_card}
    echo "Player ${player} vs Beast ${round_card}"
    echo "Player ${player//[^0-9]} vs Beast ${round_card//[^0-9]}"

#    if (( ${player} < "${beast_hand[$round-1]}" ))
#    then
#        echo 'you die'
#    fi
    round+=1

    echo 'traverse'
}

initialize_beast_hand
initialize_player_hand
traverse
#
#dead=0
#
#while (( ${dead} == 0 ));
#do
#    get_input
#    if (( ${mode} == ${TRAVERSE} ))
#    then
#        traverse
#    elif (( ${mode} == ${DODGE} ))
#    then
#        echo "dodge"
#    else
#        exit 1
#    fi
#done

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


