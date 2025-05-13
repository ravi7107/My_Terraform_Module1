
import subprocess
import time

host = "10.50.3.70"  # Replace with the host or IP address you want to ping
output_file = "controlroom.txt"

while True:
    print("Pinging host...")
    try:
        result = subprocess.check_output(["ping", "-c", "1", host], text=True, stderr=subprocess.STDOUT)
        print(result)
        with open(output_file, "a") as file:
            file.write(result)
    except subprocess.CalledProcessError as e:
        print(e.output)
        with open(output_file, "a") as file:
            file.write(e.output)
    
    timestamp = time.strftime("%Y-%m-%d %H:%M:%S")
    print("Timestamp:", timestamp)
    with open(output_file, "a") as file:
        file.write("Timestamp: " + timestamp + "\n")
    
    time.sleep(1)  # Adjust the sleep duration as needed
