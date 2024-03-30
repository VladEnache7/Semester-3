import multiprocessing
import socket
import subprocess
import sys
import struct

# 1.   The client takes a string from the command line and sends it to the server. The server interprets the string as a command with its parameters. It executes the command and returns the standard output and the exit code to the client.

def client_handler(clientSocket, address):
    """
    Handle a client connection.
    :param clientSocket: the client socket object
    :param address: the client address
    """
    try:
        # get the command from the client
        command = clientSocket.recv(1024).decode()

        # execute the command and get the results (stdout and exit code)
        stdout, stderr = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE).communicate()
        exit_code = subprocess.Popen.returncode

        # send the results to the client
        clientSocket.sendall(stdout)
        clientSocket.sendall(str(exit_code).encode())
    except socket.error as msg:
        print(msg)


    print("Client disconnected: " + str(address))
    clientSocket.close()

if __name__ == "__main__":
    try:
        serverSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        serverSocket.bind(("0.0.0.0", 7777))
        serverSocket.listen(5)
    except socket.error as msg:
        print(msg)
        sys.exit()

    # Create a pool of worker processes.
    pool = multiprocessing.Pool()

    while True:
        clientSocket, address = serverSocket.accept()
        print("Received connection from: " + str(address))
        pool.apply_async(func=client_handler, args=(clientSocket, address))
