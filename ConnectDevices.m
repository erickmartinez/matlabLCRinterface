function [handle_lcr,h_arduino] = ConnectDevice(app)
% This function opens a GPIB connection to the LCR meter and Arduino
% 
% Paramaters
% ----------
% app : obj
%   A handle to the GUI instance
%
% Returns
% -------
% handle_lcr : gpib obj
%   A handle to the LCR meter's GPIB
% h_arduino ; arduino obj 
%   A handle to the arduino

    handle_lcr  = 0;
    success     = 1;
    h_arduino   = 0;
    DisconnectDevices(app);
    
    % Try opening the connection to the LCR meter
    try
        % create a GPIB connection
        handle_lcr = gpib('KEYSIGHT',7,app.LCRGPIBAddress.Value);
        % Set the size of the input buffer
        set(handle_lcr, 'InputBufferSize', 101*4*8+1+6);
        % Change the timeout of the connection
        handle_lcr.Timeout = 120;%  timeout value of 30 seconds is used.
        % Open the connection
        fopen(handle_lcr);
        % Configure the connection
        set(handle_lcr, 'Name', 'HP4284A_GPIB');
        set(handle_lcr,'EOSMode','read&write');
        set(handle_lcr,'EOSCharCode','LF');

        
        fprintf(handle_lcr, '*RST;*CLS');
        fprintf(handle_lcr, 'FORM ASCII');
        fprintf(handle_lcr, 'OUTP:HPOW ON');        % BIAS OPTION ON
        fprintf(handle_lcr, 'TRIG:SOUR BUS');       % GPIB TRIGGER MODE
        fprintf(handle_lcr, 'DISP:PAGE MEAS');
        fprintf(handle_lcr, 'APER MED');           % SET INTEGRATION TIME TO MED
    
        % If the connection was opened turn the lamp green
        app.LCRLamp.Color = [0 1 0];

    catch err
        msgTxt = getReport(err);
        fprintf('Error connecting LCR meter:\n');
        fprintf(msgTxt);
        fprintf('\n');
        success = 0;
    end

    
    
    % Opening connection to arduino
     try
        % Create a connection to Arduino
        h_arduino = arduino(app.ArduinoAddress.Value, 'Uno'); (1)
        
        % If connection successful, ArduinoLamp turns green
        app.ArduinoLamp.Color = [0 1 0];
        
    % Catching any error found while opening connection to Arduino
    catch err
        % Store error message in arduino_error
        arduino_error = getReport(err);
        % print a message if there's an error + line break
        fprintf('Error connecting Arduino:\n');
        % print the actual error message
        fprintf(arduino_error);
        % line break
        fprintf('\n');
     end
    
     if (success) 
        app.AcquisitionPanel.Visible    = 'on';
        app.GraphsPanel.Visible         = 'on';
        app.CorrectionsPanel.Visible    = 'on';
     end
 
end
