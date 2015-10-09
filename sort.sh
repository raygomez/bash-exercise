#!/bin/bash


if [ $# -lt 1 ]
then 
  echo 'It need at least one argument.'
  echo "Usage:./sort.sh [asc|desc] numbers..."
  exit -1
fi

arg1=$1

if [ "$arg1" == 'asc' ]
then 
  mode=

elif [ "$arg1" == 'desc' ]
then 
  mode='-r'
else
  echo "Usage:./sort.sh [asc|desc] numbers..."
  exit -1
fi

echo ${@:2} | tr ' ' '\n' | sort ${mode}

