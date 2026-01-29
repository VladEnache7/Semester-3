import socket

# creating the socket
client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
print("socket created")
client.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
print("broadcast ")
client.bind(('localhost', 7777))
print('bind')
# client.sendto(b's', ('192.168.0.0', 1234))
# print("send to ")




while True:
    data, addr = client.recvfrom(1024)
    print(data, addr)