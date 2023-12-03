import math
import random
import socket
import struct
import threading
import time

clients = []
ourPI = 0
stillAccepting = True
def tcp_send_float(sock, x):
    print("Sending: {data}".format(data=x))
    sock.send(struct.pack("!f", x))

def tcp_recv_int(sock):
    x = struct.unpack("!i", sock.recv(4))[0]
    print("Received: {data}".format(data=x))
    return x

def tcp_send_string(sock, string):
    print("Sending: {data}".format(data=string))
    sock.send(string.encode('ascii'))


def tcp_recv_string(sock, size=1024):
    string = sock.recv(size).decode('ascii')
    print("Received: {data}".format(data=string))
    return string


def tcp_server_init(ip_address, port):
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((ip_address, port))
    server_socket.listen(7)
    print("TCP Server RUNNING...")
    return server_socket


def udp_send_int(sock, x, dest_address):
    print("Sending {data}".format(data=x))
    sock.sendto(struct.pack("!i", x), dest_address)


def udp_recv_int(sock):
    number, address = sock.recvfrom(4)
    converted_number = struct.unpack('!i', number)[0]
    print("Received {data}".format(data=converted_number))
    return converted_number, address


def udp_send_string(sock, string, dest_address):
    print("Sending {data}".format(data=string))
    sock.sendto(string.encode('ascii'), dest_address)


def udp_recv_string(sock):
    string, address = sock.recvfrom(1024)
    converted_string = string.decode('ascii')
    print("Received {data}".format(data=converted_string))
    return converted_string, address


def udp_server_init(ip_address, port):
    udp_socket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)
    udp_socket.bind((ip_address, port))
    print("UDP Server RUNNING...")
    return udp_socket



def get_message(udp_socket):
    message, address = udp_recv_string(udp_socket)
    print(message)

# find if the point (x, y) is inside the circle with radius 1
def insideCircle(x, y):
    return math.sqrt(math.pow(x, 2) + math.pow(y, 2)) < 1

def convertNumbers(x, y):
    return (x - 50) / 100, (y - 50) / 100

def sendingApproximation(acceptSocket:socket.socket, not_stop):
    start = time.time()
    while start + 10 > time.time():
        tcp_send_float(acceptSocket, abs(math.pi - ourPI))
        time.sleep(5)


def acceptingClients(not_stop):
    tcpSocket = tcp_server_init('localhost', 1234)
    threads = []

    start = time.time()
    while start + 10 > time.time():
        acceptSocket, addr = tcpSocket.accept()
        print(f"Connected with {addr}")
        sendingThread = threading.Thread(target=sendingApproximation, args=(acceptSocket, not_stop))
        sendingThread.start()
        threads.append(sendingThread)

    for thread in threads:
        thread.join()
    print("Joined all the accepting threads")

def readingKeyboard():
    global stillAccepting
    n = input("")
    stillAccepting = False


def serverCode():
    global ourPI, stillAccepting
    # creating the udp socket
    udpSocket = udp_server_init(f"127.0.0.{random.randint(10, 240)}", 7777)
    # ourPI = 0
    totalPoints = 0
    insidePoints = 0
    stillAccepting = True

    # readThread = threading.Thread(target=readingKeyboard)
    # readThread.start()

    # take the current time
    start = time.time()

    accepingThread = threading.Thread(target=acceptingClients, args=(lambda: stillAccepting, ))
    accepingThread.start()
    while start + 10 > time.time():
        x, addr = udp_recv_int(udpSocket)
        y, addr = udp_recv_int(udpSocket)
        print(f"Got x, y = ({x}, {y}) from {addr}")
        totalPoints += 1
        x, y = convertNumbers(x, y)
        if insideCircle(x, y):
            insidePoints += 1

        ourPI = 4 * (insidePoints / totalPoints)
        print(ourPI)

    # finishing the thread
    stillAccepting = False
    accepingThread.join()



if __name__ == "__main__":
    serverCode()
    # start = time.time()
    # while start + 5 > time.time():
    #     print("a")
    #     time.sleep(1)










