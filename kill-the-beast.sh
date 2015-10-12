#!/bin/bash

declare -a clubs=($(for i in {1..13}; do echo ${i}; done))
declare -a spades=($(for i in {1..13}; do echo ${i}; done))
declare -a hearts=($(for i in {1..13}; do echo ${i}; done))
declare -a diamonds=($(for i in {1..13}; do echo ${i}; done))

get_input(){
    valid=0

    while [ "${valid}" -eq 0 ]
    do
        echo 'Enter input:'
        read input
        case "${input}" in

        [Tt][Rr][Aa][Vv][Ee][Rr][Ss][Ee])
            echo "Traverse"
            valid=1
            ;;
        [Dd][Oo][Dd][Gg][Ee])
            echo "Dodge"
            valid=1
            ;;
        [Qq][Uu][Ii][Tt])
            echo "Quit"
            valid=1
            ;;
        *)
            echo "Not valid"
        esac
    done
}

#get_input

print_card() {
    card=""
    case "$1" in
    1)
      card='Ace'
    ;;
    2|3|4|5|6|7|8|9|10)
      card="$1"
    ;;
    11)
      card='Jack'
    ;;
    12)
      card='Queen'
    ;;
    13)
      card='King'
    ;;
    *)
      echo 'Not a valid card.'
    esac

    card+=" of "
    card+="$2"
    echo -e "You get $card."
}

print_card 10 "Spade"
print_card 1 "Spade"
print_card 11 "Heart"
print_card 12 "Diamond"
print_card 13 "Club"