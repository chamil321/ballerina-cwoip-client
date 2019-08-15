import ballerinax/java;

public type SerialPort object {

    private handle comPort = java:createNull();

    public function __init(string portDescription) {
        self.comPort = getPort(portDescription);
    }

    public function openPort() returns boolean {
        return openPort(self.comPort);
    }

    //public function closePort() returns boolean {
    //    return closePort(self.comPort);
    //}

    public function poll() returns string {
        var value = java:toString(poll(self.comPort));
        //var value = poll(self.comPort));
        if (value is string) {
            return value;
        }
        return "";
    }
};

public function getPort(string port) returns handle = @java:Method {
    class: "com.chamil.serial.SerialPortReader",
    name:"getPort"
} external;

public function openPort(handle comPort) returns boolean = @java:Method {
    class: "com.chamil.serial.SerialPortReader",
    name:"openPort"
} external;

public function poll(handle comPort) returns handle = @java:Method {
    class: "com.chamil.serial.SerialPortReader",
    name:"poll"
} external;

//public function closePort(handle comPort) returns boolean = @java:Method {
//    class: "com.chamil.serial.SerialPortReader",
//    name:"closePort"
//} external;