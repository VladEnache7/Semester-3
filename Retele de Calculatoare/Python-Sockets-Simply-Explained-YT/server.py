import socket

HOST = 'localhost'
PORT = 5555

# creating the socket
try:
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    print("Socket created")
except socket.error as e:
    print(str(e))
    exit(1)

# binding the socket to the ip and port
try:
    server.bind((HOST, PORT))
    print("Socket binded")
except socket.error as e:
    print(str(e))
    exit(1)

# listening for incoming connections
try:
    server.listen(5)
    print("Socket listening")
except socket.error as e:
    print(str(e))
    exit(1)

while True:
    # accepting connection from the client
    try:
        communication_socket, client_address = server.accept()
        print(f"Connected with {client_address}")
    except socket.error as e:
        print(str(e))
        exit(1)

    # receive the message from the client and decode it, network to host
    message = communication_socket.recv(1024).decode()
    print(f"Message from the client {message}")

    # send an approval
    communication_socket.send("I got your message!".encode('utf-8'))

    # closing the communication_socket
    communication_socket.close()