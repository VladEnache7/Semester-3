import socket

# create the socket
serverSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
print(f"socket() - success")

# bind the socket
serverSocket.bind(("0.0.0.0", 12345))
print(f"bind() - success")
# listening
serverSocket.listen(5)
print(f"listen() - success")


while True:
    acceptSocket, addr = serverSocket.accept()
    print(f"accept() - success - from {addr}")

    # receiving the string
    message = acceptSocket.recv(1024).decode()
    print(f"received {message}")
    # reverse the string
    message = message[::-1]
    message = message[1:]

    acceptSocket.send(message.encode())
    print(f"send {message}")

    acceptSocket.close()

