
x = serialportlist("available")'
arduinoObj = serialport(x,9600)
configureTerminator(arduinoObj,hex2dec('5A')); % Data package ends with byte 0x5A