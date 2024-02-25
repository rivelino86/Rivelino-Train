#!/bin/bash

echo "|################################################################|"
echo "|#        This script help us to test if the sever              #|"
echo "|#                than installed is ready                       #|"
echo "|#               ### copy rigth  Kossi ###                      #|"
echo "|################################################################|"
echo ""

command="" 

echo "Starting ................"
sleep 1
echo ""

while [ "$command" = "" ]
do
    echo "Server is pending..."

    sleep 2
    
    command=$(curl $1 2>/dev/null)
    
    if [ "$command" != "" ]
    then
        echo "Server is ready !"
        curl $1 
		echo ""
        
    fi
    
done
