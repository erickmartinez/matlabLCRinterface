function toggleArduinoPin(app,pinNumber,onOrOff)
% This function will turn the selected pin on the arduino on or off
% Parameters
% app: obj
%   The handle to the app designer GUI instance
% pinNumber: int
%   The pin number to toggle
% onOrOff: 1,0
%   The pin state
    pinNumber_str = sprintf('D%d',pinNumber);
    try
        if onOrOff == 1
            writeDigitalPin(app.handle_arduino,pinNumber_str,1);
        else
            configurePin(app.handle_arduino,pinNumber_str,'Unset');
        end
    catch err
        msg = sprintf('Error with pin %d toggle',pinNumber);
        logMessage(app,msg)
        logMessage(app,err.message);
        getReport(err)
    end
end

