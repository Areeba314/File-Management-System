#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdlib.h>

#define FIFO_FILE "MYFIFO"
#define BUFFER_SIZE 1024

void error(const char *msg) {
    perror(msg);
    exit(EXIT_FAILURE);
}

int main() {
	int fdWrite, fdRead;
	char buffer[BUFFER_SIZE];
	mkfifo(FIFO_FILE, 0666);

	char filename[256];
	printf("Enter the name of the file (with extension):\n");
	fgets(filename, sizeof(filename), stdin);
	// Remove newline character from filename
	filename[strcspn(filename, "\n")] = '\0';

    	int fork_id = fork();

   	//parent process - reads from file and writes to FIFO
    	if (fork_id > 0) { 
        	fdWrite = open(FIFO_FILE, O_WRONLY);
        
        	if (fdWrite == -1) {
            		error("FIFO File could not be opened for writing.");
        	}

		printf("Enter text to write to the file ('exit' to finish):\n");
	
		//open file in reading mode
        	FILE *file = fopen(filename, "r");
        
        	if (file == NULL) {
            		error("File could not be opened.");
        	}

        	while (fgets(buffer, sizeof(buffer), stdin) != NULL) {
			if (strncmp(buffer, "exit", 4) == 0) {
				break;
                	}
            		write(fdWrite, buffer, strlen(buffer) + 1);
        	}

        	fclose(file);
        	close(fdWrite);
     	} 
     	
     	//child process - reads from FIFO and prints to stdout
     	else if (fork_id == 0) { 
        	fdRead = open(FIFO_FILE, O_RDONLY);
        
        	if (fdRead == -1) {
            		error("FIFO File could not be opened for reading.");
        	}
        
        	// Open file for appending
         	FILE *file = fopen(filename, "a"); 
         
         	if (file == NULL) {
               	 	error("File could not be opened.");
            	}	

         	while (read(fdRead, buffer, sizeof(buffer)) > 0) {
            		printf("Read from file: %s", buffer);
            		fprintf(file, "%s", buffer);
        	}
		fclose(file);
        	close(fdRead);
    	} 
    	else {
        error("Fork could not be formed.");
    }
    return 0;
}
