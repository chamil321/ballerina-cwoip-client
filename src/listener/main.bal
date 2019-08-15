import ballerina/io;
import ballerinax/java;

public function main() {
    io:println("***********************************************");
    io:println("*            CW Over IP (CWoIP)               *");
    io:println("***********************************************");

    // Provide the serial port which needs to be listened at
    string portDescriptor = "/dev/pts/10";

    // Create SerialPort object
    SerialPort comPort = new(portDescriptor);

    // Opening port
    if (comPort.openPort()) {
        string input = "";

        while (input != "\n") {
            // Poll is blocking call which waits until the availability of bytes
            input = comPort.poll();

            //TODO : push input to ws server using a client
        }

        // Closing port
        //boolean closed = comPort.closePort();
    }
}



