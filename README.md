# Network Speed Tool (Ping-Based CLI)

A lightweight CLI tool to estimate network speed using ICMP (ping).  
It sends packets of different sizes to a target server and calculates an approximate speed based on RTT (round-trip time).

> Simple, fast, and flexible (гибкий = flexible).

---

## Features

- **CLI-Based Tool**  
  Fully customizable using command-line arguments

- **Server Selection**  
  Choose any target server (default: 8.8.8.8)

- **Custom Packet Sizes**  
  Define your own packet sizes for testing

- **Adjustable Test Count**  
  Control how many ping requests are sent per test

- **Clean Table Output**  
  Professional and aligned results display

- **Progress Bar UI**  
  Real-time progress indicator during testing

- **Error Handling**  
  Gracefully handles failed network requests

- **Average Speed Calculation**  
  Provides estimated overall speed in Mbps

---

## Installation

```bash
git clone https://github.com/kissssu/speed-test.git
cd speed-test
chmod +x speed.sh
```

## Usage

- Basic Run
```
./speed.sh
```

- Custom Server
```
./speed.sh --server 1.1.1.1
```

- Custom Packet Sizes
```
./speed.sh --packets 64,256,1024
```

- Full Example
```
./speed.sh --server 1.1.1.1 --packets 64,256,1024 --count 5
```

## Sample Output
```
=== Network Speed Tool ===
Server: 1.1.1.1
Packets: 64 256 1024
Count per test: 5

Packet Size  | Avg RTT (ms)   | Speed (Mbps)
-------------+----------------+-------------
64 B         | 42.12          | 0.01
256 B        | 38.55          | 0.05
1024 B       | 30.22          | 0.27

Progress: [##############################----------] 75%

----------------------------------------------
Average Speed: 0.11 Mbps
Done (готово = done)
```

## Options

- ```--server``` : Target server IP/domain
- ```--packets``` : Packet sizes (comma-separated)
- ```--count``` : Number of pings per packet size
- ```--help``` : Show help menu

## Important Note

This tool provides an approximate speed based on latency. It does NOT measure real bandwidth like tools such as:

- ```speedtest-cli```
- ```iperf```

Use this tool for:

- Quick diagnostics
- Network behavior testing
- Learning and experimentation

## Future Enhancements

- More accurate bandwidth estimation model
- Upload speed estimation
- Configuration file support
- Export results (JSON/CSV)
- Graph visualization
- Multi-server testing
- Installable CLI command (netspeed)

## Contribution

Contributions are welcome!

- Fork the repo
- Create a feature branch
- Commit your changes
- Push and open a PR