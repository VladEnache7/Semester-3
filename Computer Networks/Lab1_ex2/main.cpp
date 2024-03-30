#include <iostream>
#include <WinSock2.h>
#include <cstdint>

using namespace std;
int main() {
    // loading the dll
    {
        WSADATA wsadata;
        if (WSAStartup(MAKEWORD(2, 2), &wsadata) < 0) {
            perror("Error initializing Windows Socket Library");
            return -1;
        }
    }
    int returned = 0;

    // creating the socket
    SOCKET serverSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    if(serverSocket == INVALID_SOCKET){
        cout << "socket() - Error: " <<   WSAGetLastError() << endl;
        WSACleanup();
        return -1;
    }
    cout << "socket() - Successful \n";

    // setting up sockaddr_in
    struct sockaddr_in service;
    service.sin_family = AF_INET;
    service.sin_port = htons(5555);
    service.sin_addr.s_addr = htonl(INADDR_ANY);

    int serviceSize = sizeof(service);

    // binding the socket
    returned = bind(serverSocket, (sockaddr *) &service, sizeof(service));
    if(returned == SOCKET_ERROR){
        cout << "bind() - Eroor: " << WSAGetLastError() << endl;
        closesocket(serverSocket);
        WSACleanup();
        return -1;
    }
    cout << "bind() - Successful \n";

    // listening for clients
    returned = listen(serverSocket, 1);
    if(returned == SOCKET_ERROR){
        cout << "listen() - Eroor: " << WSAGetLastError() << endl;
        closesocket(serverSocket);
        WSACleanup();
        return -1;
    }
    cout << "listen() - Successful \n";

    while(true){
        // accepting clients
        SOCKET acceptSocket = accept(serverSocket, (sockaddr *) &service, &serviceSize);
        if (acceptSocket == INVALID_SOCKET){
            cout << "accept() - Error: " << WSAGetLastError() << endl;
            closesocket(serverSocket);
            WSACleanup();
            return -1;
        }
        cout << "accept() - Successful \n";

        // receiving data
        char buffer[200] = {0};
        returned = recv(acceptSocket, buffer, 200, 0);
        if(returned == SOCKET_ERROR){
            cout << "recv() - Error: " << WSAGetLastError() << endl;
            closesocket(acceptSocket);
            closesocket(serverSocket);
            WSACleanup();
            return -1;
        }
        cout << "recv() - Successful \n Received " << returned << " bytes\n With message: " << buffer << endl;

        int nrOfSpaces = 0;
        for(int p = 0; p < returned; p++){
            if(buffer[p] == ' ')
                nrOfSpaces ++;
        }

        int sending = htonl(nrOfSpaces);
        // sending the number of spaces
        returned = send(acceptSocket, (char *) &sending, sizeof(sending), 0);
        if(returned == SOCKET_ERROR){
            cout << "send() - Error: " << WSAGetLastError() << endl;
            closesocket(acceptSocket);
            closesocket(serverSocket);
            WSACleanup();
            return -1;
        }
        cout << "send() - Successful \n Sent " << returned << " bytes\n With message: " << nrOfSpaces << endl;

        closesocket(acceptSocket);
    }

    closesocket(serverSocket);
    WSACleanup();
    return 0;
}
