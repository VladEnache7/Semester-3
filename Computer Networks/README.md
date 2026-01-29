
# 🌐 Computer Networks

This course covers the architecture of the Internet, moving from the Application Layer down to the Physical Layer (Top-Down approach). It combines low-level **Socket Programming** (TCP/UDP) with practical Network Engineering using **Cisco Packet Tracer**.

### 📅 Weekly Syllabus

The laboratory sessions transition from coding (Weeks 1-6) to network simulation (Weeks 8-14).

| Week | 👨‍🏫 Lecture Content | 💻 Laboratory Focus |
|:---:|:---|:---|
| **1** | **Intro:** Definitions, Topologies, Network types | **Setup:** Tools, VM configuration, Build systems |
| **2** | **Sockets:** API, TCP vs UDP programming | **TCP Basic:** Simple Client-Server application |
| **3** | **Models:** OSI vs TCP/IP Layered Models | **TCP Concurrent:** Handling multiple clients (Process/Thread) |
| **4** | **IP Layer:** Datagrams, Addressing, ARP, Checksums | **Multiplexing:** Using the `select()` system call, Wireshark |
| **5** | **Addressing:** Subnets, Supernets, CIDR, Masks | **UDP Basic:** Simple Client-Server implementation |
| **6** | **UDP:** Datagram structure, Ports, Processes | **UDP Advanced:** Broadcast, Ping, Traceroute logic |
| **7** | **TCP Protocol:** Segments, Reliability principles | ❗ **MID-TERM EVALUATION (Socket Programming)** |
| **8** | **Flow Control:** Sliding Window, Congestion Avoidance | **Packet Tracer:** Installation & Environment intro |
| **9** | **ICMP:** Broadcast, Multicast, Error signaling | **Simulation I:** Simple network simulation |
| **10** | **App Layer:** HTTP, SMTP, FTP protocols | **Simulation II:** Physical vs Logical network design |
| **11** | **DNS:** Domain Name System architecture | **NAT:** Network Address Translation configuration |
| **12** | **Routing:** Algorithms (Link State/Distance), RIP, OSPF | **Routing:** Configuring RIP (Routing Information Protocol) |
| **13** | **Physical:** Transmission media, Fiber, Wireless | **Complex Design:** Full enterprise network simulation |
| **14** | **Reliability:** Error detection and correction | ❗ **FINAL LAB EVALUATION** |

---

### 📚 Key Topics Breakdown

<details>
<summary><strong>Click to expand detailed topic list</strong></summary>

#### Part I: Application & Transport (Socket Programming)
*   **Sockets API:** `socket()`, `bind()`, `listen()`, `accept()`, `connect()`, `send()`, `recv()`.
*   **Concurrency:** Handling multiple clients using `fork()` (multiprocessing) or threads.
*   **I/O Multiplexing:** Using `select()` to handle multiple file descriptors in a single thread.
*   **Protocols:**
    *   **TCP:** Connection-oriented, Reliable, Flow control (Sliding Window), Congestion Control.
    *   **UDP:** Connectionless, Unreliable (Fire and Forget), low overhead.

#### Part II: Network Layer & Engineering
*   **IP Addressing:** IPv4 Classful vs Classless (CIDR), Subnet Masks.
*   **Routing:** How packets find their destination.
    *   **RIP:** Distance-Vector protocol.
    *   **OSPF:** Link-State protocol.
    *   **BGP:** Border Gateway Protocol (routing between autonomous systems).
*   **Services:** DNS (Naming), NAT (Private to Public IP translation), ARP (IP to MAC translation).

</details>

---

### 🛠️ Resources & Tools

*   **Wireshark** - The standard for network protocol analysis (packet sniffing).
*   **Cisco Packet Tracer** - Network simulation tool for routers/switches.
*   **Netcat (`nc`)** - The "Swiss Army knife" of networking for debugging sockets.
*   **Beej's Guide to Network Programming** - The legendary guide for learning C socket programming.

---

> *"There are two ways to write error-free programs; only the third one works."* — Alan Perlis
