import socket
import struct
import threading
import time

test = "10+2;4/2;3*1"
answers = [12, 2, 3]


def sendingTests(stop):
    while True:
        udpSocket.sendto(test.encode('ascii'), ('255.255.255.255', 7777))
        print("sendingTests() - broadcast the test")
        if stop():
            print("sendingTests() stopping - received stop condition")
            udpSocket.close()
            break

        time.sleep(2)


def correctingTest(acceptSocket: socket.socket, addr):
    print(f"Started correcting for {addr}")
    correct = 0
    # getting the answers
    for i in range(len(answers)):
        index = struct.unpack("!I", acceptSocket.recv(4))[0]
        answer = struct.unpack("!I", acceptSocket.recv(4))[0]

        print(f"Received {index} - {answer} from {addr}")
        correct += (answer == answers[index])

    # sending the result
    result = (correct // len(answers)) * 100
    acceptSocket.send(struct.pack("!I", result))
    print(f"Sent {result} to {addr}")



def acceptingStudents():
    while True:
        try:
            acceptSocket, addr = tcpSocket.accept()
        except:
            print("acceptingStudents() stopping - received stop condition")
            break
        print(f"accept() from student {addr}")
        correctingThread = threading.Thread(target=correctingTest, args=(acceptSocket, addr))
        correctingThread.start()


if __name__ == "__main__":
    # creating UDP Socket
    udpSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    print("udp socket()")

    udpSocket.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    print("setsockopt() broadcast")

    udpSocket.bind(('localhost', 7777))
    print("bind() udp")

    # creating TCP Socket
    tcpSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    print("tcp socket()")

    tcpSocket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    print("tcp setsockopt REUSEADDR")

    tcpSocket.bind(('localhost', 1234))  # or maybe 0.0.0.0
    print("bind() tcp")

    tcpSocket.listen(10)
    print("listen()")

    stop_threads = False
    sendThread = threading.Thread(target=sendingTests, args=(lambda: stop_threads,))
    acceptThread = threading.Thread(target=acceptingStudents)

    sendThread.start()
    acceptThread.start()

    time.sleep(12)
    stop_threads = True
    tcpSocket.close()

    sendThread.join()
    acceptThread.join()
    print("joined all threads")
