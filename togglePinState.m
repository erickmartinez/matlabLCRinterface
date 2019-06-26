function togglePinState(app,pinNumber,value)
% This function will toggle the pin state between active and inactive
% LCR meter will only collect measurements from pins set to active state.
% Parameters
% ----------
% app : obj
%   The instance of the app designer gui
% pinNumber : int
%   The number of the pin to change the status
% value : bool
%   The status of the pin 1 = active, 0 = inactive

% The array with the pin states is stored as a public property in the app
% designer
    
    % define active and inactive colors
    inactiveColor   = [0.502 0.502 0.502];
    activeColor     = [0.3 0.75 0.93];
    % Get the handle to the background color for the selected pin
    buttonHandle = getButtonHandle(app,pinNumber);
    
    % Change the background color for the pin button
    
    if value == true
        buttonHandle.BackgroundColor    = activeColor;
    else
        buttonHandle.BackgroundColor    = inactiveColor;
    end
    
    % Change the state of the pin
    buttonHandle.Value = value;
    
    % Change the pin state in the array
    app.activePins(pinNumber) = value;
end