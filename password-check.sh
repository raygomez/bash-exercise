#!/bin/bash

echo 'Enter password:'
read password

error=""
echo "This is the password:${password}"

if [ "${#password}" -lt 12 ]
then
 error+="Length should be 12 or greater.\n"
fi

filtered="${password//[^A-Za-z]}"
if [ "${#filtered}" -lt 5 ]
then
 error+="Must contain at least 5 letters.\n"
fi

filtered="${password//[^A-Z]}"
if [ "${#filtered}" -lt 1 ]
then
 error+="Must contain at least 1 capital letter.\n"
fi

filtered="${password//[^a-z]}"
if [ "${#filtered}" -lt 1 ]
then
 error+="Must contain at least 1 small caps letter.\n"
fi

filtered="${password//[^0-9]}"
if [ "${#filtered}" -lt 1 ]
then
 error+="Must contain at least 1 number.\n"
fi

filtered="${password//[^@\#\$%\*\+\-\=]}"
if [ "${#filtered}" -lt 1 ]
then
 error+="Must contain at least one of the following @ # $ % * + - =.\n"
fi

if [ "${error}" ]
then
    echo -e "\nPassword is weak."
    echo -e "${error}"
else
    echo -e "\nPassword is strong."
fi
