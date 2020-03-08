#!/bin/sh
#Photo-reorganizer
#Matias Serino Marin 2020-03-08
#We obtain the actual route

actualRoute=$(pwd)

#We receive the route where the photos disordered are located
echo "Please paste here the route to your photos disordered:"
read initialRoute

if [ -d $initialRoute ] 
then
    echo "Directory $initialRoute is working perfectly!"
    echo "Please write the starting year for organize: "
    read firstYear
    actualYear=$(date +%Y)
    if [ $actualYear -gt $firstYear ]
    then
        i=$firstYear
        one=1
        actualYearIncreased=$((actualYear+1))       #For include the actual year also.
        
        while [ $i -lt $actualYearIncreased ];
        do
            #This will be repeated as many times as the years you have in pictures
            






            i=$((i+1))
        done

    else
        echo "The first year needs to be in the past. "
        exit

    fi 


else
    echo "Error: Directory $initialRoute is not working."
fi