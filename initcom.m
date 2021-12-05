clear all;
serialportlist("available")'
arduinoObj = serialport("COM6",9600)
configureTerminator(arduinoObj,hex2dec('5A')); % Data package ends with byte 0x5A