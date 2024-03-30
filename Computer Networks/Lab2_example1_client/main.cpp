#include <WinSock2.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#define max 100

int main() {
    // loading the dll
    {
        WSADATA wsadata;
        if (WSAStartup(MAKEWORD(2, 2), &wsadata) < 0) {
            perror("Error initializing Windows Socket Library");
            return -1;
        }
    }

    SOCKET serverSocket = INVALID_SOCKET;
    serverSocket = socket(PF_INET, SOCK_STREAM, 0);
    if (serverSocket < 0) {
        fprintf(stderr, "Eroare la creare socket client.\n");
        WSACleanup();
        return 1;
    }

    // Observatie: Deoarece dimensiunea tipului int difera de la platforma la platforma,
    // (spre exemplu, in Borland C in DOS e reprezentat pe 2 octeti, iar in C sub Linux pe
    // 4 octeti) este necesara utilizarea unor tipuri intregi standard. A se vedea
    // stdint.h.
    struct sockaddr_in server;
    char buffer[max];

    // setting up the server
    memset(&server, 0, sizeof(struct sockaddr_in));
    server.sin_family = AF_INET;
    server.sin_port = htons(4321);
    server.sin_addr.s_addr = inet_addr("127.0.0.1");

    SOCKET connectSocket = INVALID_SOCKET;
    int returned = connect(serverSocket, (struct sockaddr *) &server, sizeof(struct sockaddr_in));
    if (returned == SOCKET_ERROR) {
        fprintf(stderr, "Eroare la conectarea la server.\n");
        closesocket(serverSocket);
        WSACleanup();
        return 1;
    }

    printf("Dati o fraza pentru trimis la server: ");
    fgets(buffer, max, stdin);

    // !!! important - trimit lungimea sirului + 1 pentru a trimite pe socket si caracterul NULL (0) care marcheaza sfarsitului sirului.
    // paragraful 1 din protocol
    int byteCount = send(serverSocket, buffer, strlen(buffer) + 1, 0);
    if (byteCount != strlen(buffer) + 1) {
        fprintf(stderr, "Eroare la trimiterea datelor la server.\n");
        closesocket(serverSocket);
        WSACleanup();
        return 1;
    }

    // paragraful 5 din protocol
    int32_t result;
    byteCount = recv(serverSocket, (char *) &result, sizeof(int32_t), MSG_WAITALL);
    result = ntohl(result);
    if (byteCount != sizeof(int)) {
        fprintf(stderr, "Eroare la primirea datelor de la client.\n");
        closesocket(serverSocket);
        WSACleanup();
        return 1;
    }

    printf("Serverul a returnat %d caractere spatiu in sirul trimis.\n", result);

    closesocket(serverSocket);
    WSACleanup();
}