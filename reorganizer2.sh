#!/bin/sh
#Photo-reorganizer
#Matias Serino Marin 2020-03-08
#We obtain the actual route

actualRoute=$(pwd)

#We receive the route where the photos disordered are located
echo "Please paste here the explicit route to your photos disordered:"
read initialRoute
echo "Please paste here the explicit route where you want to save the ordered photos (Avoid last slash "/") :"
read endingRoute
slash="/"

endingRoute=$endingRoute$slash

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

        #Go into each folder, quit the files and save it all into temporaryAll
        temporaryAll="temporaryAll"
        mkdir $endingRoute$temporaryAll
        #Copy lonely files first, if they exist
        cd $initialRoute
        #cp *.jpg $endingRoute$temporaryAll  #Fix, only if the files exist. 
        #List the folders and save the list into a file

        directoryList="DIRECTORY_LIST"
        destinationFile1=$actualRoute$slash$directoryList
        ls -d  */ > $destinationFile1
        
        while IFS= read -r directory
        do
            echo "$directory"
            cd $directory
            #check if into the directory there are files .jpg
            tree | grep jpg > JPG_FILES_PRESENT
            if [ -s JPG_FILES_PRESENT ]
            then
                cp *.jpg $endingRoute$temporaryAll
            fi
            cd ..
        done < $destinationFile1

        cd $endingRoute$temporaryAll

        while [ $i -lt $actualYearIncreased ];
        do
            #This will be repeated as many times as the years you have in pictures
            #Command to get the creation date of a picture using imagemagick (Apt repo disponible)
            #identify -verbose 121337.jpg | grep date:create
            mkdir $endingRoute$i

            fileList="FILE_LIST"
            destinationFile2=$actualRoute$slash$fileList
            ls > $destinationFile2      #In $destinationFile2 we have the list of files
            
            dateCreate="DATE_CREATE"
            destinationDateCreate=$actualRoute$slash$dateCreate
            pwd
            while IFS= read -r file
            do
                echo "$file"
                identify -verbose $file | grep date:create > $destinationDateCreate
                
                ##Here continue coding. 
                ##Parse only the year, then move the file into the correct folder that has the name equal to the parsed date









            done < $destinationFile2
            




            i=$((i+1))
        done
        cat $dateCreate

    else
        echo "The first year needs to be in the past. "
        exit

    fi 


else
    echo "Error: Directory $initialRoute is not working."
fi