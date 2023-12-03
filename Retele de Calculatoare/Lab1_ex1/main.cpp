#include <iostream>
#include <WinSock2.h>
#include <cstdint>

using namespace std;
int main() {
    int returned = 0;
    // loading the dll
    {
        WSADATA wsadata;
        if (WSAStartup(MAKEWORD(2, 2), &wsadata) < 0) {
            perror("Error initializing Windows Socket Library");
            return -1;
        }
    }

    // creating the socket
    SOCKET serverSocket = INVALID_SOCKET;
    serverSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (serverSocket == INVALID_SOCKET){
        cout << "Error at socket():" << WSAGetLastError() << endl;
        WSACleanup();
        return -1;
    } else {
        cout << "socket() - successful" << endl;
    }

    // setting up sockaddr_in
    struct sockaddr_in service;
    service.sin_family = AF_INET; // TCP or UDP
    service.sin_port = htons(1234); // port number in network byte order (big endian)
    service.sin_addr.s_addr = htonl(INADDR_ANY);  // any address on the local machine

    // associating a local address with a socket
    returned = bind(serverSocket, (sockaddr *) &service, sizeof(service));
    if(returned == SOCKET_ERROR){
        cout << "bind() failed: " << WSAGetLastError() << endl;
        closesocket(serverSocket);
        WSACleanup();
        return -1;
    } else {
        cout << "bind() - successful\n";
    }

    // listening for incoming connections
    returned = listen(serverSocket, 5);
    if(returned == SOCKET_ERROR){
        cout << "listen() failed: " << WSAGetLastError() << endl;
        closesocket(serverSocket);
        WSACleanup();
        return -1;
    } else {
        cout << "listen() - successful\n";
    }

    while(true){
        SOCKET acceptSocket;
        struct sockaddr_in client;
        int clientSize = sizeof(client);
        memset(&client, 0, clientSize);
        acceptSocket = accept(serverSocket, (struct sockaddr*) &client, &clientSize);
        if (acceptSocket == INVALID_SOCKET){
            cout << "accept() failed: " << WSAGetLastError() << endl;
            closesocket(serverSocket);
            WSACleanup();
            return -1;
        } else {
            cout << "accept() - successful\n";
        }

        int element, length = 0;

        //  getting the length of the array
        int byteCount = recv(acceptSocket, (char*) &length, sizeof(length), 0);
        if(byteCount == SOCKET_ERROR){
            cout << "recv() failed: " << WSAGetLastError() << endl;
            closesocket(acceptSocket);
            closesocket(serverSocket);
            WSACleanup();
            return -1;
        }
        length = ntohl(length);
        cout << "recv() - successful\n Received: " << byteCount << " bytes\n With content: " << length << endl;
        int totalSum = 0;

        //  getting the array
        for(int i = 0; i < length; i++){
            //  getting the array
            byteCount = recv(acceptSocket, (char*) &element, sizeof(element), 0);
            if(byteCount == SOCKET_ERROR){
                cout << "recv() failed: " << WSAGetLastError() << endl;
                closesocket(acceptSocket);
                closesocket(serverSocket);
                WSACleanup();
                return -1;
            }
            element = ntohl(element);
            cout << "recv() - successful\n Received: " << byteCount << " bytes\n With content: " << element << endl;

            totalSum += element;
        }

        //  sending the sum
        totalSum = htonl(totalSum);
        byteCount = send(acceptSocket, (char*) &totalSum, sizeof(totalSum), 0);
        if(byteCount == SOCKET_ERROR){
            cout << "send() failed: " << WSAGetLastError() << endl;
            closesocket(acceptSocket);
            closesocket(serverSocket);
            WSACleanup();
            return -1;
        }
        totalSum = ntohl(totalSum);
        cout << "send() - successful\n Sent: " << byteCount << " bytes\n With content: " << totalSum << endl;

        closesocket(acceptSocket);
    }

    // cleaning up
    closesocket(serverSocket);
    WSACleanup();
    return 0;
}

