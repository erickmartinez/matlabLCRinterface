function toggleArduinoPin(arduino_hdl,pinNumber,onOrOff)
% This function will turn the selected pin on the arduino on or off
% Parameters
% arduino_hdl: obj
%   The handle to the arduino connection
% pinNumber: int
%   The pin number to toggle
% onOrOff: 1,0
%   The pin state
    pinNumber_str = sprintf('D%d',pinNumber);
    try
        writeDigitalPin(arduino_hdl,pinNumber_str,onOrOff);
    catch err
        msg = sprintf('Error with pin %d toggle',pinNumber);
        logMessage(app,msg)
        logMessage(app,err.message);
        getReport(err)
    end
end

