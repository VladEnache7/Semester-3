import socket
import struct

# creating the socket
serverSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
print("socket() - successful")

# binding the socket
serverSocket.bind(('0.0.0.0', 1234))
print("bind() - successful")

# listening
serverSocket.listen(5)
print("listen() - successful")

while True:
    acceptSocket, addr = serverSocket.accept()
    print(f"accept() - successful - connection from {addr}")
    # receiving the length
    length = acceptSocket.recv(4)
    length = struct.unpack("!i", length)[0]
    print(f"length = {length}")

    # receiving the elements
    totalSum = 0
    for i in range(length):
        element = acceptSocket.recv(4)
        element = struct.unpack("!i", element)[0]
        print(f"v[{i}] = {element}")
        totalSum += element

    # sending the total sum
    acceptSocket.send(struct.pack("!i", totalSum))

    # closing the connection
    acceptSocket.close()


