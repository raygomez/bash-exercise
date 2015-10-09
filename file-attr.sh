#!/bin/bash


if [ $# -ne 1 ]
then
  echo 'It needs one argument.'
  exit -1
fi

arg=$1
echo
echo File:$arg
if [ ! -e "$arg" ]
then
  echo -e '\tFile does not exist.'
  exit
fi

echo -e '\tFile exists.'

if [ -r "$arg" ]
then
  echo -e '\tFile is readable.'
else
  echo -e '\tFile is not readable. '
fi


if [ -w "$arg" ]
then
  echo -e '\tFile is writable.'
else
  echo -e '\tFile is not writable. '
fi


if [ -x "$arg" ]
then
  echo -e '\tFile is executable.'
else
  echo -e '\tFile is not executable. '
fi

echo -e '\tOwner:'`stat -c %U $arg`

echo
