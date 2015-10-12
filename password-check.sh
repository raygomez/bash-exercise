#!/bin/bash

echo 'Enter password:'
read password

error=""

echo "This is the password:$password, length=${#password}"

if [ "${#password}" ]
