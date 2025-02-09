#!/bin/bash

#the files are compiled once, and may be executed multiple times
gcc ipc_program.c -o ipc_program 
gcc C_Project.c -o program
gcc sorting_files.c -o sort_program

# Function to perform linear search for the file
linear_search() {
    local filename=$1
    local found=0

    # Loop through all files and directories recursively
    for file in $(find . -type f); do
        if [ "$(basename "$file")" == "$filename" ]; then
            echo "File found"
            found=1
            break
        fi
    done

    if [ $found -eq 0 ]; then
        echo "File not found"
    fi
}

i=0
while [ "$i" -lt 100 ]
do  
	#execute the main c program 
	./program 
    
	#prompts user for input
	read -p "Enter your choice: " option
	echo " "


	if [ "$option" == "1" ]; then
		echo "All the files in the directory are shown below."
		ls
		echo " "
        
        
	elif [ "$option" == "2" ]; then
		echo "Enter the file name without any extension: " 
		read filename
    	
		echo "Choose the extension of the file from the given choices below."
        	echo "1 - For a C programming file (.c)"
        	echo "2 - For a Bash Script File (.sh)"
        	echo "3 - For a Text File (.txt)"
        	read -p "Enter your choice: " fileExtension

        	if [ "$fileExtension" == "1" ]; then
            		touch "$filename.c"
            		echo "File creation was successful."           
        	elif [ "$fileExtension" == "2" ]; then
            		touch "$filename.sh"
            		echo "File creation was successful."                   
        	elif [ "$fileExtension" == "3" ]; then
            		touch "$filename.txt"
            		echo "File was created successfully."             		                       
        	else
            		echo "ERROR! Invalid Input."           		
        	fi
        	echo " " 
                
                
	elif [ "$option" == "3" ]; then
        	read -p "Enter the file name for deletion (with extension): " deleteFile

		#check if file exists
        	if [ -f "$deleteFile" ]; then
        		#remove file
            		rm "$deleteFile"
            		echo "File was deleted successfully."
        	else
            		echo "ERROR! No file named $deleteFile exists."
        	fi
        	echo " "
   
   
	elif [ $option == 4 ]; then
    		echo "Enter the current file name (with extension)" 
    		read currentName
    
    		echo "Please wait..." 
    		sleep 3

    		if [ -f "$currentName" ]; then
        		echo "The file $currentName exists."
        		echo " "
        		echo "Enter the new name of the file (with extension)." 
        		read newName      		
        		#rename the file to new name
        		mv "$currentName" "$newName"
        		echo "The file has been successfully renamed."
    		else
    			echo "ERROR! No file named $currentName exists."
    		fi
    		echo " "
    
    
	elif [ $option == 5 ]; then
    		echo "The files in the directory are shown below."
    		ls
    		#run ipc file for ipc   
    		./ipc_program    
    		echo " "
    
    
	elif [ $option == 6 ]; then
		echo "Enter file name that you want to search:"
    		read filename
    		linear_search "$filename"
		
		
	elif [ $option == 7 ]; then
    		echo "Enter the name of the file name (with extension) to view details." 
    		read detailOfFile
    		
   		#check if file exists
    		if [ -f "$detailOfFile" ]; then
        		echo "The file $fileToSearch exists."
        		echo " "
        		echo "Please wait..."
        		sleep 4
        		echo "The details are shown below."
        		stat "$detailOfFile"
    		else
        		echo "ERROR! No file named $detailOfFile exists." 
    		fi
    		echo " "
    
    
	elif [ $option == 8 ]; then
    		echo "Enter the file name (with extension) to view content below."
    		read readFile

   		#check if file exists
    		if [ -f "$readFile" ]; then
    			echo "The file $readFile exists."
    			echo "Please wait..."
        		sleep 3
        		echo "The content of file $readFile is shown below."
        		cat "$readFile"
    		else
        		echo "ERROR! No file named $readFile exists." 
    		fi
    		echo " "

    
	elif [ $option == 9 ]; then
    		echo "Enter the file name (with extension) to sort below."
    		read sortfile
    		
    		#check if file exists
    		if [ -f "$sortfile" ]; then
    			echo "Please wait..."
        		sleep 3
        		echo "The sorted content of file $sortfile is shown below."
        		sort "$sortfile"
    		else
        		echo "ERROR! No file named $sortfile exists." 
    		fi
    		echo " "
    
    
	elif [ $option == 10 ]; then
    		echo "Showing all the folders in the directory(s)."
    		echo "Please wait..."
    		sleep 3
    		ls -d */
    		echo " "    
    
    
	elif [ $option == 11 ]; then
    		echo "Of which extension, should the files be?"
        	echo "1 - For a C programming file (.c)"
        	echo "2 - For a Bash Script File (.sh)"
        	echo "3 - For a Text File (.txt)"
        	read -p "Enter your choice: " fileExtension
        	
        	echo "Please wait..."
    
    		if [ $fileExtension == 1 ]; then
    			sleep 3
        		echo "List of all C programming files (.c) is shown below." 
        		ls *.c
    		elif [ $fileExtension == 2 ]; then
    			sleep 3
        		echo "List of all Bash Script Files (.sh) is shown below." 
        		ls *.sh       		
     		elif [ $fileExtension == 3 ]; then
    			sleep 3
        		echo "List of all Text Files (.txt) is shown below." 
        		ls *.txt
         	else
            		echo "ERROR! Invalid Input."           		
        	fi
        	echo " " 

    
	elif [ $option == 12 ]; then
		echo "All the directories are being loaded."		
		echo "Please wait..."
		sleep 3		
    		echo "The total number of directories is: "
    		echo */ | wc -w 
    		echo " "
    		
    
	elif [ $option == 13 ]; then
		echo "Your Request of Sorting file is Generated." 
                echo "Enter the directory path to sort files:"
                read directory
                directory=$(eval echo "$directory")
                echo "Please wait..."
                 sleep 3
               ./sort_program "$directory"
		echo " "


	elif [ "$option" == "0" ]; then
		echo "The program is successfully terminated."
		break


	else
        	echo "ERROR! Invalid Input." 
        	echo " "
	fi
	
	#wait to load menu again
	sleep 3
    
	i=$((i+1))
done





