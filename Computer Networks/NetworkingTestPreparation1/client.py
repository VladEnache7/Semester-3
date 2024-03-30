import random
import socket
import struct
import threading
import time

if __name__ == "__main__":
    udpSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    print("udp socket()")

    # udpSocket.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    # print("setsockopt() broadcast")
    ip = f"127.0.0.{random.randint(10, 200)}"
    udpSocket.bind((ip, 7777))
    print("bind() udp")

    # creating TCP Socket
    tcpSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    print("tcp socket()")

    tcpSocket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    print("tcp setsockopt REUSEADDR")

    test, addr = udpSocket.recvfrom(1024)
    test = test.decode('ascii')
    print(f"received {test} from {addr}")

    questions = test.split(';')
    print(questions)

    tcpSocket.connect(('localhost', 1234))
    # time.sleep(2)
    print("tcpSocket connect()")
    for i in range(len(questions)):
        tcpSocket.send(struct.pack("!I", i))
        print(f"send index {i} to the teacher")
        if questions[i].find('+') != -1:
            print(questions[i].split('+'))
            # var1, var2 = 0, 0
            var1, var2 = questions[i].split('+')
            result = int(var1) + int(var2)
            tcpSocket.send(struct.pack("!I", result))
            print(f"send result {result} to the teacher")
        elif questions[i].find('-') != -1:
            print(questions[i].split('-'))
            # var1, var2 = 0, 0
            var1, var2 = questions[i].split('-')
            result = int(var1) - int(var2)
            tcpSocket.send(struct.pack("!I", result))
            print(f"send result {result} to the teacher")
        elif questions[i].find('*') != -1:
            print(questions[i].split('*'))
            var1, var2 = questions[i].split('*')
            result = int(var1) * int(var2)
            tcpSocket.send(struct.pack("!I", result))
            print(f"send result {result} to the teacher")
        elif questions[i].find('/') != -1:
            print(questions[i].split('/'))
            # var1, var2 = 0, 0
            var1, var2 = questions[i].split('/')
            result = int(var1) // int(var2)
            tcpSocket.send(struct.pack("!I", result))
            print(f"send result {result} to the teacher")

    grade = struct.unpack("!I", tcpSocket.recv(4))[0]
    print(f"Got grade {grade}")



