#!/bin/bash
declare -a deck=($(for i in {1..13}; do echo C${i}; done)
                 $(for i in {1..13}; do echo S${i}; done)
                 $(for i in {1..13}; do echo D${i}; done)
                 $(for i in {1..13}; do echo H${i}; done))

declare -a beast_hand
declare -a discard
declare player

TRAVERSE=0
DODGE=1
QUIT=2
mode=-1

logs=""

get_input(){
    valid=0

    while [ "${valid}" -eq 0 ]
    do
        echo 'Enter input:'
        logs+='Enter input:\n'
        read input
        logs+="${input}\n"

        #bash4
        #input="${input,,}"
        input=`echo $input | tr '[:upper:]' '[:lower:]'`
        case "${input}" in
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
    esac

    card+=" of "
    case "${1}" in
        C*)card+='Club';;
        S*)card+="Spades";;
        D*)card+="Diamond";;
        H*)card+="Heart";;
        *) echo ${1}
    esac

    echo -e "$card."
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
    echo "Player card is ${player}."
    logs+="Player card is ${player}\n"
}

dead=0
fail=0

compare(){

    fail=0
    pdigit="${1//[^0-9]}"
    bdigit="${2//[^0-9]}"
    psuit="${1//[0-9]}"
    bsuit="${2//[0-9]}"

    if [ "${pdigit}" -lt "${bdigit}" ]
    then fail=1
    elif [ "${pdigit}" == "${bdigit}" ]
    then
        if [ "${psuit}" == 'H' ]; then echo ''
        elif [ "${psuit}" == 'D' ]
        then
            if [ "${bsuit}" == 'H' ]; then fail=1
            fi
        elif [ "${psuit}" == 'S' ]
        then
            if [ "${bsuit}" == 'C' ]
            then echo ''
            else fail=1
            fi
        else fail=1
        fi
    else echo ''
    fi

}

round=0
traverse(){
    echo 'Traversing:'
    logs+='Traversing:\n'

    (( index = round ))
    round_card="${beast_hand[${index}]}"

    echo "Player ${player} vs Beast ${round_card}"
    logs+="Player ${player} vs Beast ${round_card}\n"
    compare ${player} ${round_card}

    if [ ${fail} -ne 0 ]; then dead=1
    else
        echo 'Traversing successful.'
        logs+='Traversing successful.\n'
        (( round++ ))
    fi
}

dodge(){

    (( index = round ))
    round_card="${beast_hand[${index}]}"
    echo 'Dodging:'
    logs+='Dodging:\n'
    echo "Player ${player} vs Beast ${round_card}"
    logs+="Player ${player} vs Beast ${round_card}\n"
    compare ${player} ${round_card}

    if [ ${fail} -eq 0 ]; then
        discard=( ${discard[@]} ${player} ${round_card} )
        echo "Discarding ${player} and ${round_card}"
        logs+="Discarding ${player} and ${round_card}\n"
        initialize_player_hand

        i=$(($RANDOM % ${#deck[@]}))
        (( index = round ))
        beast_hand[$index]=${deck[${i}]}
        deck=(${deck[@]})
        echo 'Dodging unsuccessful.'
        logs+='Dodging unsuccessful.\n'
    else
        echo 'Dodging successful.'
        logs+='Dodging successful.\n'
        (( round++ ))
    fi
    echo
}

display(){ while read data; do print_card ${data[@]}
    done
}


initialize_beast_hand
initialize_player_hand
discard=()
while (( ${dead} == 0 )) && (( round < 10 ));
do
    echo -e '\nRound' $(( round + 1 ))
    logs+="\nRound $(( round + 1 ))\n"
    get_input

    if (( ${mode} == ${TRAVERSE} ))
    then traverse
    elif (( ${mode} == ${DODGE} ))
    then dodge
    else
        echo 'Quitting so early.'
        logs+='Quitting so early.\n'
        exit 1
    fi
done

if (( ${dead} == 0))
then
    echo 'You successfully killed the monster.'
    logs+='You successfully killed the monster.\n'
    echo -e ${logs} > "JournalOfHeroes.txt"
else
    echo 'You died.'
    logs+='You died.\n'
    echo -e ${logs} > "Obituary.txt"
fi


echo "Remaining cards:"
echo "${deck[@]}"
#echo "${deck[@]:1:2}" | tr ' ' '\n' | display
echo "Encounter cards:"
echo "${beast_hand[@]}"
echo "Discard pile:"
echo "${discard[@]}"
