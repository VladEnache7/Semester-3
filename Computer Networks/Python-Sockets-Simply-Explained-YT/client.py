import socket

HOST = 'localhost'
PORT = 5555

# creating the socket of the client
try:
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    print("Socket created")
except socket.error as e:
    print(str(e))
    exit(1)

# connecting to the server
try:
    client.connect((HOST, PORT))
    print("Connected to the server")
except socket.error as e:
    print(str(e))
    exit(1)


# sending a message to the server
client.send("Que passa my amigo".encode('utf-8'))

# receiving a message from the server
message = client.recv(1024)
print(f"Message from the server: {message.decode('utf-8')}")

# closing the client socket
client.close()


