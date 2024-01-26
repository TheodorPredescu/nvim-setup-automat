#include <cstdio>
#include <iostream>

int main() {
    const char* oldFilename = "./plecare/plecare.txt";
    const char* newFilename = "./destinatie/proba.txt";

    std::cout<<"(1). Move\n(2). Delete\n\nCommand: ";
    int command;
    std::cin>>command;
    if (command == 1) {
        // Attempt to move the file
        if (std::rename(newFilename, oldFilename) != 0) {
            perror("Error moving file");
        } else {
            printf("File moved successfully\n");
        }
    } else if (command == 2) {
        if (std::remove(oldFilename) != 0) {
            perror("Error moving file");
        } else {
            printf("File removed successfully\n");
        }
    }
    return 0;
}
