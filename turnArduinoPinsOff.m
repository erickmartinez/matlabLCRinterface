function turnArduinoPinsOff(arduino_hdl)
%  This function will turn all available Arduino pins off
%  availablePins = 2:1:9;
    off = 0;
    for pin = 2:1:9
        toggleArduinoPin(arduino_hdl,pin,off);
    end
end

