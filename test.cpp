#include <cstdio>
#include <iostream>
#include <tlhelp32.h>
#include <windows.h>

void ListProcesses() {
  const char *processName = "WhatsApp.exe";
  HANDLE hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if (hSnapshot == INVALID_HANDLE_VALUE) {
    std::cerr << "Error creating process snapshot" << std::endl;
    return;
  }
  std::cout << "nush";
  pe32.dwSize = sizeof(PROCESSENTRY32);

  if (Process32First(hSnapshot, &pe32)) {
    do {
      if (_stricmp(pe32.szExeFile, processName) == 0) {
        HANDLE hProcess =
            OpenProcess(PROCESS_TERMINATE, FALSE, pe32.th32ProcessID);
        if (hProcess != NULL) {
          TerminateProcess(hProcess, 0);
          CloseHandle(hProcess);
          return;
        }
      }
    } while (Process32Next(hSnapshot, &pe32));
  }
  CloseHandle(hSnapshot);
}

int main() {
<<<<<<< HEAD
  const char *oldFilename = "./plecare/plecare.txt";
  const char *newFilename = "./destinatie/proba.txt";

  std::cout << "(1). Move\n(2). Delete\n\nCommand: ";
  int command;
  std::cin >> command;
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
