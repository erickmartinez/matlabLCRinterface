function turnArduinoPinsOff(app)
%  This function will turn all available Arduino pins off
%  availablePins = 2:1:9;
    off = 0;
    for pin = 2:1:9
        toggleArduinoPin(app,pin,off);
    end
end

