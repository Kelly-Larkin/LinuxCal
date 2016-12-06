#!/bin/bash

function setUp {
    #creates other files
    touch today
    touch day
    
    #creates nested folders for todo list based on importance
    mkdir todo
    cd todo
    mkdir 1
    mkdir 2
    mkdir 3
    mkdir 4
    cd ..
    
    #sets up nested folders for the years
    mkdir years
    cd years
    curYear=$(date +%Y)
    year=$(date +%Y)
    mkdir $year
    mkdir $(($year +1))
    mkdir $(($year +2))
    mkdir $(($year +3))
    mkdir $(($year +4))
    mkdir $(($year +5))
    maxYear=$(($year +6))
while [[ (($year -lt $maxYear)) ]]
do
    cd $year
    month=1
    while [[ (($month -lt 13)) ]]
    do
	mkdir $month
	cd $month
	days=1
	while [[ (($days -lt 32)) ]]
	do
	    mkdir $days
	    days=$(($days +1))
	    cd ..
	done
	cd ..
	month=$(($month +1))
    done
    cd ..
    year=$(($year +1))
done
cd ..
}

function addEvent {
    #adds an event to the calendar
    cd years
    echo "Please answer the folloing questions about your event:"
    echo "What is the name of your event?"
    read name
    echo "What year is the event in?"
    echo "Please pick a year within five years of the current year"
    read year
    cd $year
    echo "What month is the event in?"
    echo "Enter 1 for January"
    echo "Enter 2 for February"
    echo "Enter 3 for March"
    echo "Enter 4 for April"
    echo "Enter 5 for May"
    echo "Enter 6 for June"
    echo "Enter 7 for July"
    echo "Enter 8 for August"
    echo "Enter 9 for September"
    echo "Enter 10 for October"
    echo "Enter 11 for November"
    echo "Enter 12 for December"    
    read month
    cd $month
    echo "What day of the month is the event?"
    read day
    cd $day
    touch $name
    echo "what time is the event?"
    read time
    fullTime="time: $time"
    echo $fullTime >> $name
    echo "Is it a recurring event?"
    echo "Enter Y for yes and n for no"
    read recurring
    fullRec="Recurring: $recurring"
    echo $fullRec >> $name
    echo "How important is the event?"
    echo "Enter 1 for Very important"
    echo "Enter 2 for Somewhat important"
    echo "Enter 3 for Kind of important"
    echo "Enter 4 for Not important"
    read importance
    fullImport="Importance: $importance"
    echo $fullImport >> $name
    echo "Please add any other notes about this event or enter 'c' to continue"
    read notes
    if [[ ! $notes == "c" ]]
    then
	echo $notes >> $name
    fi
    cd ..
    cd ..
    cd ..
    cd ..
}

function todo {
    #adds an action to the todo list
    echo "Please write the action that you want to add to the todo list"
    read title
    echo "How important is the action?"
    echo "Enter 1 for Very important"
    echo "Enter 2 for Somewhat important"
    echo "Enter 3 for Kind of important"
    echo "Enter 4 for Not important"
    read importance
    cd todo
    cd $importance
    touch $title
    fullTitle="Action: $title"
    echo $fullTitle >> $title
    fullImport="Importance: $importance"
    echo $fullImport >> $title
    echo "Please add any other notes about this action or enter 'c' to continue"
    read notes
    if [[ ! $notes == "c" ]]
    then
	echo $notes >> $title
    fi
    echo " " >> $title
    cd ..
    cd ..
}

function finished {
    #removes an item from the todo list
    echo "Enter the action that was completed"
    read name
    cd todo
    folder=1
    while [[ $folder -lt 5 ]]
    do
	cd $folder
	files=$(ls)
	for f in files
	do
	    if [[ "$f" == "$name" ]]
	    then
		rm $f
	    fi
	done
	folder=$(($folder +1))
	cd ..
    done
    echo "Removed!"
    cd ..
}

function getDay {
    #outputs the calendar events for the day after you are prompted for the day
    #user prompt
    touch day
    cd years
    echo "Please input the year of the date you desire to know about"
    read year
    cd $year
    echo "Please input the month of the date you desire to know about"
    read month
    cd $month
    echo "Please input the day of the month of the date you desire to know about"
    read day
    
    cd $day
    files=$(ls)
    for i in $files
    do
	echo $i >> day
	cat $i >>day
	echo " "
    done
    emacs day &
    cd ..
    cd ..
    cd ..
    cd ..
}

function getToday {
    #prints out your calendar events and todo list sorted for importance
    #Adding calendar events to the day file
    touch day
    curFolder=$(pwd)
    cd years
    year=$(date +%Y)
    cd $year
    month=12 #$(date +%m)
    cd $month
    day=6 #$(date +%d)
    cd $day
    touch day
    files=$(ls $(pwd) )
    for i in $files
    do
	if [[ ! $i == "day" ]]
        then
	    echo $i >> day
	    cat $i >> day
	    echo " " >> day
        fi
    done
    mv day $curFolder
    cd ..
    cd ..
    cd ..
    cd ..
    
    #adding todo list
    origFolder=$(pwd)
    cd todo
    touch todoFull
    folder=1
    curFolder=$(pwd)
    while [[ $folder -lt 5 ]]
    do
	cd $folder
	files=$(ls)
	touch todo$folder
	for f in $files
	do
	    if [[ ! $f == "todo$folder" ]]
	    then
		echo $f >>todo$folder
		cat $f >>todo$folder
		echo " " >>todo$folder
	    fi
	done
	mv todo$folder $curFolder
	cd ..
	cat todo1 >> todoFull
	cat todo2 >> todoFull
	cat todo3 >> todoFull
	cat todo4 >> todoFull
	folder=$(($folder +1))
    done
    mv todoFull $origFolder
    cd ..

    #putting todo list and calendar in the same document
    echo "TO DO LIST" >> today
    cat todoFull >> today
    echo " " >>today
    echo "CALENDAR" >>today
    cat day >> today
    emacs today &
}

function todoList {
    #outputs the todo list in order of importance
    origFolder=$(pwd)
    cd todo
    touch todoFull
    folder=1
    curFolder=$(pwd)
    while [[ $folder -lt 5 ]]
    do
	cd $folder
	files=$(ls)
	touch todo$folder
	for f in $files
	do
	    if [[ ! $f == "todo$folder" ]]
	    then
		echo $f >>todo$folder
		cat $f >>todo$folder
		echo " " >>todo$folder
	    fi
	done
	mv todo$folder $curFolder
	cd ..
	echo "VERY IMPORTANT" >> todoFull
	echo "" >>todoFull
	cat todo1 >> todoFull
	echo "SOMEWHAT IMPORTANT" >>todoFull
	echo "" >>todoFull
        cat todo2 >> todoFull
        echo "KIND OF IMPORTANT" >> todoFull
	echo "" >>todoFull
	cat todo3 >> todoFull
	echo "NOT IMPORTANT" >>todoFull
	echo "" >>todoFull
	cat todo4 >> todoFull
	folder=$(($folder +1))
    done
    mv todoFull $origFolder
    cd ..
    emacs todoFull &

}

#runs everytime
if [[ ! -d years ]]
then
    setUp
    echo "Please enter your command or q to quit"
    read action
    if [[ $action == "q" ]]
    then
	echo " "

    else
	$action
    fi
else
    echo "Please enter your command or q to quit"
    read action
    if [[ $action == "q" ]] 
    then
	echo " "
    else
	$action
    fi
fi

while [[ ! $action == "q" ]] 
do
    echo "Please enter your command or q to quit"
    read action
    if [[ $action == "q" ]] 
    then
	echo " "
    else
	$action
    fi
done


