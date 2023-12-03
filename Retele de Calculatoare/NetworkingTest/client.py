import random
import socket
import struct
import threading
import time


def udp_client_init():
    client_socket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)
    client_socket.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    client_socket.bind((f"127.0.0.{random.randint(10, 200)}", 7777))
    print("UDP for client Created socket")
    return client_socket

def tcp_client_init(ip_address, port):
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect((ip_address, port))
    print("You are CONNECTED")
    return client_socket

def tcp_send_int(sock, x):
    print("Sending: {data}".format(data=x))
    sock.send(struct.pack("!i", x))

def tcp_recv_float(sock):
    x = struct.unpack("!f", sock.recv(4))[0]
    print("Received: {data}".format(data=x))
    return x

def udp_send_int(sock, x, dest_address):
    print("Sending {data}".format(data=x))
    sock.sendto(struct.pack("!i", x), dest_address)


def udp_recv_int(sock):
    number, address = sock.recvfrom(4)
    converted_number = struct.unpack('!i', number)[0]
    print("Received {data}".format(data=converted_number))
    return converted_number, address

def gettingApproximation():
    nrApproximations = 0
    tcpSocket = tcp_client_init('localhost', 1234)
    aproximation = tcp_recv_float(tcpSocket)
    #print(f"Got aproximation {aproximation} from server")
    start = time.time()
    while start + 9 > time.time():
        aproximation = tcp_recv_float(tcpSocket)
        # print(f"Got aproximation {aproximation} from server")

def clientCode():
    udpSocket = udp_client_init()
    N = 5
    randValues = []
    # generating random numbers
    for i in range(N):
        randValues.append((random.randint(0, 100), random.randint(0, 100)))

    receiveThread = threading.Thread(target=gettingApproximation)
    receiveThread.start()

    for i in range(N):
        # sending the numbers
        udp_send_int(udpSocket, randValues[i][0], ('255.255.255.255', 7777))
        udp_send_int(udpSocket, randValues[i][1], ('255.255.255.255', 7777))
        print(f"Sent ({randValues[i][0]}, {randValues[i][1]})")

    # waiting for the thread
    receiveThread.join()


if __name__ == "__main__":
    clientCode()