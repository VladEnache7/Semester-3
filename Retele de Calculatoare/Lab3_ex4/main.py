import threading
import time

import select
import socket
import datetime

peers = []
answers = {}
malformed = []


def receive(stop):
    print('Receive thread started')
    while True:
        if stop():
            break
        try:
            data, addr = client.recvfrom(1024)

            data = data.decode('utf-8')
            if addr not in peers:
                peers.append(addr)
                answers[addr] = 0
            else:
                answers[addr] += 1
            if data == 'TIMEQUERY\0':
                # get current time from system
                current_time = datetime.datetime.now().time()
                client.sendto(f'TIME {current_time}\0'.encode('utf-8'), addr)
                print(f'Sent time {current_time} to {addr}')
            elif data == 'DATEQUERY\0':
                current_date = datetime.datetime.now().date()
                client.sendto(f'DATE {current_date}\0'.encode('utf-8'), addr)
                print(f'Sent date {current_date} to {addr}')
            else:
                malformed.append(addr)
        except:
            pass


def send_time(stop):
    print('Send time thread started')
    while True:
        client.sendto('TIMEQUERY\0'.encode('utf-8'), ('255.255.255.255', 7777))
        print(f"Me {client.getsockname()} -> Broadcast time query")
        for peer in peers:
            answers[peer] -= 1
            # if answers[peer] <= -3:
            #     peers.remove(peer)
            #     # remove the peer from the dictionary of answers
            #     answers.pop(peer)
        if stop():
            break
        time.sleep(5)


def send_date(stop):
    print('Send date thread started')
    while True:
        client.sendto('DATEQUERY\0'.encode('utf-8'), ('255.255.255.255', 7777))
        print(f"Me {client.getsockname()} -> Broadcast date query")
        for peer in peers:
            answers[peer] -= 1
            # if answers[peer] <= -3:
            #     peers.remove(peer)
            #     answers.pop(peer)
        if stop():
            break
        time.sleep(10)


if __name__ == '__main__':
    # creating the UDP socket
    global client
    try:
        client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        print('Socket created')
        client.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
        print('Broadcast set')
        client.bind(('127.0.0.9', 7777))
        print('Bind')
    except socket.error:
        print('Error at socket(), setsockopt() or bind()')
        exit(1)

    # start the threads
    stop_threads = False
    receive_thread = threading.Thread(target=receive, args=(lambda: stop_threads,))
    send_time_thread = threading.Thread(target=send_time, args=(lambda: stop_threads,))
    send_date_thread = threading.Thread(target=send_date, args=(lambda: stop_threads,))

    receive_thread.start()
    send_time_thread.start()
    send_date_thread.start()
    print('Started threads')

    time.sleep(30)
    print("30 seconds passed -> stop threads")
    # kill the threads
    stop_threads = True
    receive_thread.join()
    send_time_thread.join()
    send_date_thread.join()
