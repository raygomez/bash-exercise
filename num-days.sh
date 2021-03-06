#!/bin/bash


if [ $# -ne 1 ]
then
  echo 'It needs one argument.'
  exit -1
fi

arg=$1

if [ $arg -eq 1 ]
then
  echo 31
elif [ $arg -eq 2 ]
then
  echo 28
elif [ $arg -eq 3 ]
then
  echo 31
elif [ $arg -eq 4 ]
then
  echo 30
elif [ $arg -eq 5 ]
then
  echo 31
elif [ $arg -eq 6 ]
then
  echo 30
elif [ $arg -eq 7 ]
then
  echo 31
elif [ $arg -eq 8 ]
then
  echo 31
elif [ $arg -eq 9 ]
then
  echo 30
elif [ $arg -eq 10 ]
then
  echo 31
elif [ $arg -eq 11 ]
then
  echo 30
elif [ $arg -eq 12 ]
then
  echo 31
else
  echo 'Not a valid month.'
fi

case "$arg" in

1 | 3 | 5 | 7 | 8 | 10 | 12)
  echo 31
;;
4 | 6 | 9 | 11)
  echo 30
;;
2)
  echo 28
;;
*)
  echo 'Not a valid month.'

esac
