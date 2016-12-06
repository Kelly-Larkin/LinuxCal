For the calendar, I decided to use a five-year calendar since my implementation is not the most optimal in terms of files and using space.  

The setUp function uses nested folders to create the calendar.  It first makes the folder for the year, then enters and adds folders 1-12 for each month (as described when asking for user input) and then each month gets 31 days.  It also 

The addEvent function adds an eent to teh calendar.  It takes in various inputs, including the year, month, and day (in that order) in order to properly move to the correct folder.  It will then take in other information to put in the "calendar event" so the user can know more details about the event.

The function todo adds an item to the todo list based on the importance on a scale from 1-4 where the user inputs that importance.  This function just adds items to the todo list, with the function todoList actually reading the list.  It is similar to the calendar because it uses nested folders (within the todo folder, there is a folder 1 through 4 for the different importance levels)

The function finished prompts the user for the action to be removed from the todo list.  It then goes into the todo folder and recursively looks through each folder for an action that matches the input.  If tehre is a match, it is removed from the list.

The function getDay allows the user to input the year, month, and day and get out the events on their schedule for that day.  The code is programmed to go to the folder for that day and cat all the event details onto one document which is then pulled up for the user to see and then move that file into the main project folder so that it is not just specific to that particular day. 

The function getToday allows the user to access their calendar events for the day and their todo list all in one document.  The code itself functions similarly to the getDay function and todo

The function todoList outputs everything on the todo list based on importance.  It is coded to go into the todo file and then go into each of the folders for different importances and creates a document of the items listde in that folder.  This file is then moved up to the todo file, where there will be 4 other files like this.  They are then catted into a full todo list, still seperated by importance.

The .sh file then runs the base code that runs everytime.  It checks if setUp has been run and that all the files have been made.  If this has not happened, it runs setUp as decribed above.  It then asks the user for an input of one of the functions listed above.  No parameters should be given at this time since the user will be prompted for those by the functions themselves.  At the end of each function, the user will be prompted to either run another function or quit by inputting "q".
