# ballerina-cwoip-client

CW over IP client is used to send and receive cw over internet.

Build serial-port-reader java project usinf `mvn clean install` and put the jar into libs directory
Compile ballerina package using `ballerina compile` from the root

Simulate serial port using socat as follows

`socat -d -d pty,raw,echo=0 pty,raw,echo=0`

Which opens two ports to communicate. Use one of the port as the listner port and provide user input to the other port 

` echo "chamil" > /dev/pts/8"`

