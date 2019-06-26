function [NPINS,pinNumbers] = NPinsIdentifier(app)
% Identify how many testing pins are currently active and return an array
% with the index of those pins.
% Parameters
% ----------
% app : obj
%   A handle to the app designer GUI instance
%
% Returns
% -------
% NPINS : integer
%   The number of active pins
% pinNumbers : [integer]
%   An array with the indices of the active pins

    % Get the active pins array ([0 1 0 0 1 ...])
    activePins  = app.activePins;
    TOTAL_PINS  = length(activePins);       % The total number of pins
    NPINS       = sum(activePins == 1);     % The number of active pins
    pinNumbers  = zeros(NPINS,1);           % The indices of the active pins
    
    % Define a counter to access the pinNumbers array
    count = 1;
    % Iterate over all the pins
    for Pin = 1:TOTAL_PINS
        % If the pin is set to 1 (true) store that pin number and increase
        % the counter.
        if activePins(Pin) == true
           pinNumbers(count) = Pin;
           count = count + 1;
        end
    end
end

