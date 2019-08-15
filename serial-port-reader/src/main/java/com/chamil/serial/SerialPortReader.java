package com.chamil.serial;

import com.fazecast.jSerialComm.SerialPort;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * This is serial port reader class.
 *
 */
public class SerialPortReader {

    private static final Logger LOG = LoggerFactory.getLogger(SerialPortReader.class);

    public static SerialPort getPort(String portDescriptor) {
        return SerialPort.getCommPort(portDescriptor);
    }

    public static boolean openPort(SerialPort comPort) {
        return comPort.openPort();
    }

    public static String poll(SerialPort comPort) {
        byte[] readBuffer = new byte[0];
        while (comPort.bytesAvailable() <= 1) {
            try {
                Thread.sleep(20);
            } catch (InterruptedException e) {
                LOG.warn(e.getMessage());
            }
        }

        readBuffer = new byte[comPort.bytesAvailable() - 1];
        int numRead = comPort.readBytes(readBuffer, readBuffer.length);
//        System.out.println("Read " + numRead + " bytes.");

        return new String(readBuffer);
    }

    public static void closePort(SerialPort comPort) {
        comPort.closePort();
    }

    public static void main (String [] argv) {
        // Uncomment following to test java port read
        SerialPort port = getPort("/dev/pts/10");
        openPort(port);
        String poll = "";
        while (!poll.equalsIgnoreCase("\n")) {
            System.out.println("-" + poll + "-");
            poll = poll(port);
        }
    }
}
