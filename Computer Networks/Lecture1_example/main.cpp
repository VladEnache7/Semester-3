#include <winsock2.h>
#include <cstdint>
#include <cstdio>
#include <iostream>

using namespace std;

#define SERVER_PORT 1500
#define MAX_MSG 1024

int main() {
    SOCKET Socket = INVALID_SOCKET, newConnection = INVALID_SOCKET;
    struct sockaddr_in clientAddress, serverAddress;
    char line[MAX_MSG];
    int len;
    /// initialize the Windows Sockets library only when compiled on Windows
    {
        #ifdef _WIN32
            WSADATA wsaData;
            if (WSAStartup(MAKEWORD(2, 2), &wsaData) < 0) {
                printf("Error initializing the Windows Sockets LIbrary");
                return -1;
            }
        #endif
    }
    /// AF_INET - IPv4, SOCK_STREAM - TCP, 0 - IP
    Socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    if(Socket < 0){
        perror("cannot open socket");
        WSACleanup();
        return ERROR;
    }

    /// set up the server address and port
    serverAddress.sin_family = AF_INET; /// internet socket ipv4
    serverAddress.sin_addr.s_addr = htonl(INADDR_ANY); /// host to network long (4 bytes) - convert IP address to network byte order
    serverAddress.sin_port = htons(SERVER_PORT); /// host to network short (2 bytes) - convert port number to network byte order

    int result;
    /// bind the socket to the server address and port
    result = bind(Socket, (struct sockaddr*) &serverAddress, sizeof(serverAddress));
    if (result < 0){
        perror("Cannot bind port");
        return ERROR;
    }
    cout << "Bind successfully!\n";

    /// wait for a client to connect
    listen(Socket, 5); /// the second argument is the backlog, the number of connections allowed on the incoming queue
    cout << "Server is listening on port " << SERVER_PORT << "\n";
    while(true){
        printf("waiting for data on port TCP %u\n", SERVER_PORT);
        /// accept connection from client
        len = sizeof(clientAddress);
        newConnection = accept(Socket, (struct sockaddr*) &clientAddress, &len);
        if (newConnection < 0){
            perror("Could not accept connection");
            return ERROR;
        }
        memset(line, 0x0, MAX_MSG);

        /// read data from client

        result = recv(newConnection, line, MAX_MSG, 0);

        if(result < 0){
            perror("Could not read data from client");
            return ERROR;
        }

        printf("Received following line from client %s TCP %d: %s\n", inet_ntoa(clientAddress.sin_addr), ntohs(clientAddress.sin_port), line);

        /// send data to client
        strcpy(line, "Hello from server! =)");
        result = send(newConnection, line, MAX_MSG, 0);

        if(result < 0){
            perror("Could not send data to client");
            return ERROR;
        }

        closesocket(newConnection);
    }
    /// close the socket
    #ifdef _WIN32
        WSACleanup();
    #endif

    return 0;
}
