#include <iostream>
#include <WinSock2.h>
#include <stdio.h>

using namespace std;

//int main() {
//    {
//        WSADATA wsadata;
//        if (WSAStartup(MAKEWORD(2, 2), &wsadata) < 0) {
//            perror("Error initializing Windows Socket Library");
//            return -1;
//        }
//    }
//    // creating the socket
//    SOCKET udpSocket = INVALID_SOCKET;
//    udpSocket = socket(AF_INET, SOCK_DGRAM, 0);
//    if (udpSocket == INVALID_SOCKET){
//        perror("socket(): ");
//        WSACleanup();
//        return -1;
//    } else {
//        cout << "socket()\n";
//    }
//    char broadcast = '1';
//    // setting the socket for broadcast
//    if(setsockopt(udpSocket, SOL_SOCKET, SO_BROADCAST, &broadcast, sizeof(broadcast)) < 0){
//        perror("setsockopt(): ");
//        closesocket(udpSocket);
//        WSACleanup();
//        return -1;
//    } else {
//        cout << "setsockopt()\n";
//    }
//
//    // binding the udp socket
//    struct sockaddr_in studentAddr;
//    studentAddr.sin_family = AF_INET;
//    studentAddr.sin_port = htons(1234);
//    studentAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
//
//    int returned = bind(udpSocket, (sockaddr*) &studentAddr, sizeof(studentAddr));
//    if (returned == INVALID_SOCKET){
//        perror("bind(): ");
//        closesocket(udpSocket);
//        WSACleanup();
//        return -1;
//    } else {
//        cout << "bind()\n";
//    }
//
//    struct sockaddr_in teacherAddr;
//    int len = sizeof(teacherAddr);
//    char test[1024] = {0};
//    recvfrom(udpSocket, test, 1024, 0, (sockaddr*) &teacherAddr, &len);
//    cout << "recvfrom()";
//    cout << test << endl;
//
//
//    return 0;
//}

// # client code in python
//import random
//import socket
//import struct
//import threading
//import time
//
//if __name__ == "__main__":
//    udpSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
//    print("udp socket()")
//
//    udpSocket.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
//    print("setsockopt() broadcast")
//    ip = f"127.0.0.{random.randint(10, 200)}"
//    udpSocket.bind((ip, 7777))
//    print("bind() udp")
//
//    # creating TCP Socket
//    tcpSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
//    print("tcp socket()")
//
//    tcpSocket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
//    print("tcp setsockopt REUSEADDR")
//
//    test, addr = udpSocket.recvfrom(1024)
//    test = test.decode('ascii')
//    print(f"received {test} from {addr}")
//
//    questions = test.split(';')
//    print(questions)
//
//    tcpSocket.connect(('localhost', 1234))
//    time.sleep(2)
//    print("tcpSocket connect()")
//    for i in range(len(questions)):
//        tcpSocket.send(struct.pack("!I", i))
//        print(f"send index {i} to the teacher")
//        if questions[i].find('+') != -1:
//            print(questions[i].split('+'))
//            # var1, var2 = 0, 0
//            var1, var2 = questions[i].split('+')
//            result = int(var1) + int(var2)
//            tcpSocket.send(struct.pack("!I", result))
//            print(f"send result {result} to the teacher")
//        elif questions[i].find('-') != -1:
//            print(questions[i].split('-'))
//            # var1, var2 = 0, 0
//            var1, var2 = questions[i].split('-')
//            result = int(var1) - int(var2)
//            tcpSocket.send(struct.pack("!I", result))
//            print(f"send result {result} to the teacher")
//        elif questions[i].find('*') != -1:
//            print(questions[i].split('*'))
//            var1, var2 = questions[i].split('*')
//            result = int(var1) * int(var2)
//            tcpSocket.send(struct.pack("!I", result))
//            print(f"send result {result} to the teacher")
//        elif questions[i].find('/') != -1:
//            print(questions[i].split('/'))
//            # var1, var2 = 0, 0
//            var1, var2 = questions[i].split('/')
//            result = int(var1) // int(var2)
//            tcpSocket.send(struct.pack("!I", result))
//            print(f"send result {result} to the teacher")
//
//    grade = struct.unpack("!I", tcpSocket.recv(4))[0]
//    print(f"Got grade {grade}")
// translate this python code to c++ code

int main(){
    // create udp socket
    SOCKET udpSocket = INVALID_SOCKET;
    udpSocket = socket(AF_INET, SOCK_DGRAM, 0);

    // set the socket for broadcast
    char broadcast = '1';
    if(setsockopt(udpSocket, SOL_SOCKET, SO_BROADCAST, &broadcast, sizeof(broadcast)) < 0){
        perror("setsockopt(): ");
        closesocket(udpSocket);
        WSACleanup();
        return -1;
    } else {
        cout << "setsockopt()\n";
    }

    // bind the udp socket
    struct sockaddr_in studentAddr;
    studentAddr.sin_family = AF_INET;
    studentAddr.sin_port = htons(1234);
    studentAddr.sin_addr.s_addr = inet_addr("127.0.0.10");

    int returned = bind(udpSocket, (sockaddr*) &studentAddr, sizeof(studentAddr));
    if (returned == INVALID_SOCKET){
        perror("bind(): ");
        closesocket(udpSocket);
        WSACleanup();
        return -1;
    } else {
        cout << "bind()\n";
    }

    // create tcp socket
    SOCKET tcpSocket = INVALID_SOCKET;
    tcpSocket = socket(AF_INET, SOCK_STREAM, 0);

    // set the socket for reuse address
    int reuse = 1;
    if(setsockopt(tcpSocket, SOL_SOCKET, SO_REUSEADDR, &reuse, sizeof(reuse)) < 0){
        perror("setsockopt(): ");
        closesocket(tcpSocket);
        WSACleanup();
        return -1;
    } else {
        cout << "setsockopt()\n";
    }

    // connect to the teacher
    struct sockaddr_in teacherAddr;
    teacherAddr.sin_family = AF_INET;
    teacherAddr.sin_port = htons(1234);
    teacherAddr.sin_addr.s_addr = inet_addr("127.0.0.1");

    returned = connect(tcpSocket, (sockaddr*) &teacherAddr, sizeof(teacherAddr));
    if (returned == INVALID_SOCKET){
        perror("connect(): ");
        closesocket(tcpSocket);
        WSACleanup();
        return -1;
    } else {
        cout << "connect()\n";
    }

    // receive the questions from the teacher
    recvfrom(udpSocket, test, 1024, 0, (sockaddr*) &teacherAddr, &len);
    cout << "recvfrom()";
    cout << test << endl;

    // split the questions by ;
    string questions = test;
    vector<string> questionsVector;
    string delimiter = ";";
    size_t pos = 0;
    string token;
    while ((pos = questions.find(delimiter)) != string::npos) {
        token = questions.substr(0, pos);
        questionsVector.push_back(token);
        questions.erase(0, pos + delimiter.length());
    }

    // send the index of the question to the teacher
    for (int i = 0; i < questionsVector.size(); i++) {
        send(tcpSocket, &i, sizeof(i), 0);
        cout << "send index " << i << " to the teacher\n";
        // if the question is +, -, *, /
        if (questionsVector[i].find('+') != string::npos) {
            cout << questionsVector[i].split('+') << endl;
            // var1, var2 = 0, 0
            int var1, var2 = questionsVector[i].split('+');
            int result = int(var1) + int(var2);
            send(tcpSocket, &result, sizeof(result), 0);
            cout << "send result " << result << " to the teacher\n";
        } else if (questionsVector[i].find('-') != string::npos) {
            cout << questionsVector[i].split('-') << endl;
            // var1, var2 = 0, 0
            var1, var2 = questionsVector[i].split('-');
            result = int(var1) - int(var2);
            send(tcpSocket, &result, sizeof(result), 0);
            cout << "send result " << result << " to the teacher\n";
        } else if (questionsVector[i].find('*') != string::npos) {
            cout << questionsVector[i].split('*') << endl;
            var1, var2 = questionsVector[i].split('*');
            result = int(var1) * int(var2);
            send(tcpSocket, &result, sizeof(result), 0);
            cout << "send result " << result << " to the teacher\n";
        } else if (questionsVector[i].find('/') != string::npos) {
            cout << questionsVector[i].split('/') << endl;
            // var1, var2 = 0, 0
            var1, var2 = questionsVector[i].split('/');
            result = int(var1) / int(var2);
            send(tcpSocket, &result, sizeof(result), 0);
            cout << "send result " << result << " to the teacher\n";
        }
    }



    return 0;
}
