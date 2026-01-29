import threading
import socket

host = 'localhost'
port = 5556

clients = []
nicknames = []


def create_socket_bind_listen():
    try:
        global server
        server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        print("socket created")
    except socket.error as e:
        print("socket() error - " + str(e))
        exit(1)

    # binding the socket to the ip and port
    try:
        server.bind((host, port))
        print("bind() - successful")
    except socket.error as e:
        print("bind() error - " + str(e))
        exit(1)

    # listening
    server.listen(100)
    print("listen() - successful")

def broadcast(message, from_client):
    index = clients.index(from_client)
    for client in clients:
        if client is not from_client:
            client.send(f"{nicknames[index]}: {message}".encode('ascii'))

def handle(client):
    while True:
        try:
            message = client.recv(1024).decode('ascii')
            broadcast(message, client)
        except:
            index = clients.index(client)
            nickname = nicknames[index]
            if len(clients) == 1:
                print("All clients left the chat, server is closing.")
                server.close()
                exit(1)
            broadcast(f"{nickname} left the chat", client)

            clients.remove(client)
            nicknames.remove(nickname)
            client.close()  # closing the connection with this client

def receive_clients():
    while True:
        # accepting the connection
        try:
            client, address = server.accept()
            print("accept() - successful with " + str(address))
        except socket.error as e:
            print("accept() error or chat ended - " + str(e))
            exit(1)

        # asking for a nickname
        client.send("NICK".encode('ascii'))

        # receiving the nickname
        nickname = client.recv(1024).decode('ascii')
        print(f"client {address} choose nickname: {nickname}")

        nicknames.append(nickname)
        clients.append(client)

        broadcast(f"{nickname} joined the chat", client)

        thread = threading.Thread(target=handle, args=(client,))
        thread.start()

if __name__ == '__main__':
    create_socket_bind_listen()
    receive_clients()