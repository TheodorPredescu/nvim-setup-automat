#git log-- graph-- oneline-- all-- decorate
include<iostream>
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
  // adding stuff
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
  ListProcesses();
  return 0;
}
