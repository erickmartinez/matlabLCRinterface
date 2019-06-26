function turnArduinoPinOn(app,pinNumber)
% This function will leave the selected pin on while turning the rest
% (1-8) off
    pinMap = pinNumber + 1;
    availablePins = 2:1:9;
    off = 0;
    on = 1;
    for pin = min(availablePins):1:max(availablePins)
        if  pin == pinMap
            toggleArduinoPin(app,pinMap,on);
        else 
            toggleArduinoPin(app,pin,off);
        end
    end
end