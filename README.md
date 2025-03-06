# Network Speed Estimator (Ping-Based)

This Bash script provides a rough estimate of your network speed using ping packets. It sends packets of varying sizes to a specified server and calculates the speed based on the round-trip time (RTT).

## Features

* **Ping-Based Speed Estimation:** Estimates network speed by sending ping packets of different sizes and measuring RTT.
* **Detailed Output:** Displays packet size, average RTT, and calculated speed for each packet.
* **Summary Information:** Shows the total number of packets sent and the number of successful packets.
* **Average Speed Calculation:** Calculates and displays the estimated average speed in Mbps.
* **Background Execution:** Runs the speed test in the background.
* **Clear Output:** Formatted output for better readability.

## How to Run/Clone

1.  **Clone the repository (if applicable):**

    ```bash
    git clone speed-test
    cd speed-test
    ```

2.  **Make the script executable:**

    ```bash
    chmod +x speed.sh
    ```

3.  **Run the script:**

    ```bash
    ./speed.sh
    ```

## Sample Output
```bash
--- Speed Test Results ---
Packet Size | Average RTT (ms) | Speed (Mbps)
--------------------------------------------
32 bytes     | 48.2333            | 0           
128 bytes    | 52.7333            | .01         
512 bytes    | 33.6               | .12         
1024 bytes   | 32.8333            | .24         
2048 bytes   | N/A                | Failed
--------------------------------------------
Total Packets Sent: 5
Successful Packets: 4
Estimated Average Speed: .09 Mbps
```

## Future Enhancements

* **Server Selection:** Allow users to specify the server to ping.
* **Packet Size Customization:** Allow users to customize the packet sizes used for testing.
* **More Accurate Calculations:** Explore more sophisticated methods for calculating speed.
* **Graphical Output:** Consider creating a graphical representation of the speed test results.
* **Error Handling:** Improve error handling for network issues.
* **Upload Speed:** Implement a method to estimate upload speed.
* **Configuration File:** Allow users to configure settings via a configuration file.
* **Logging:** Add logging functionality to save test results.
* **Add a progress bar:** add a progress bar during the testing.

## Contribution

Contributions are welcome! If you have any suggestions, bug fixes, or new features, please feel free to submit a pull request or open an issue.

1.  **Fork the repository.**
2.  **Create a new branch for your changes.**
3.  **Make your changes and commit them.**
4.  **Push your changes to your fork.**
5.  **Submit a pull request.**

## Dependencies

* Bash
* ping
* awk
* cut
* bc

## Disclaimer

This script provides a rough estimate of network speed. For more accurate speed tests, consider using dedicated tools like `speedtest-cli`. This script is intended for educational and troubleshooting purposes.