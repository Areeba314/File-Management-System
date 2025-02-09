#include <stdio.h>
#include <dirent.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>


void bubbleSort(char *arr[], int n) {
    for (int i = 0; i < n-1; i++) {
        for (int j = 0; j < n-i-1; j++) {
            if (strcmp(arr[j], arr[j+1]) > 0) {
                char *temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        }
    }
}


void insertionSort(char *arr[], int n) {
    for (int i = 1; i < n; i++) {
        char *key = arr[i];
        int j = i - 1;
        while (j >= 0 && strcmp(arr[j], key) > 0) {
            arr[j + 1] = arr[j];
            j = j - 1;
        }
        arr[j + 1] = key;
    }
}

int main(int argc, char *argv[]) {
  
    char *directory = argv[1];
    int sort_algorithm;

    printf("Choose sorting algorithm:\n");
    printf("1. Bubble Sort\n");
    printf("2. Insertion Sort\n");
    printf("Enter your choice: ");
    scanf("%d", &sort_algorithm);

    // Open directory
    DIR *dir = opendir(directory);
    if (dir == NULL) {
        perror("Unable to open directory");
        return 1;
    }

    // Count files
    struct dirent *entry;
    int num_files = 0;
    while ((entry = readdir(dir)) != NULL) {
        if (entry->d_type == DT_REG) {
            num_files++;
        }
    }

    // Allocate memory for file names
    char **file_names = (char **)malloc(num_files * sizeof(char *));
    rewinddir(dir);
    int index = 0;
    while ((entry = readdir(dir)) != NULL) {
        if (entry->d_type == DT_REG) {
            file_names[index] = strdup(entry->d_name);
            index++;
        }
    }
    closedir(dir);

  
    clock_t start, end;
    double cpu_time_used;
    start = clock();
    if (sort_algorithm == 1) {
        bubbleSort(file_names, num_files);
    } else if (sort_algorithm == 2) {
        insertionSort(file_names, num_files);
    } else {
        printf("Invalid option\n");
        return 1;
    }
    end = clock();
    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Sorted files:\n");
    for (int i = 0; i < num_files; i++) {
        printf("%s\n", file_names[i]);
        free(file_names[i]);
    }
    printf("Time taken to sort: %f seconds\n", cpu_time_used);
    free(file_names);

    return 0;
}

