function ConnectDevices(app)
% This function opens a GPIB connection to the LCR meter and Arduino
% 
% Paramaters
% ----------
% app : obj
%   A handle to the GUI instance
%

    success     = 1;
    DisconnectDevices(app);
    
    % Opening connection to arduino
    try
        % Create a connection to Arduino
        app.handle_arduino = arduino(app.ArduinoAddress.Value, 'Uno');
        % If connection successful, ArduinoLamp turns green
        app.ArduinoLamp.Color = [0 1 0];
        
    % Catching any error found while opening connection to Arduino
    catch err
        % print a message if there's an error + line break
        fprintf('Error connecting Arduino:\n');
        % print the actual error message
        fprintf(err.message);
        % line break
        fprintf('\n');
        getReport(err)
        success = 0;
     end
    
    % Try opening the connection to the LCR meter
    if success == 1
        try
            % create a GPIB connection
            app.handle_lcr = gpib('KEYSIGHT',7,app.LCRGPIBAddress.Value);
            % Set the size of the input buffer
            set(app.handle_lcr, 'InputBufferSize', 101*4*8+1+6);
            % Change the timeout of the connection
            app.handle_lcr.Timeout = 30;%  timeout value of 30 seconds is used.
            % Open the connection
            fopen(app.handle_lcr);
            % Configure the connection
            set(app.handle_lcr, 'Name', 'HP4284A_GPIB');
            set(app.handle_lcr,'EOSMode','read&write');
            set(app.handle_lcr,'EOSCharCode','LF');


            fprintf(app.handle_lcr, '*RST;*CLS');
            fprintf(app.handle_lcr, 'FORM ASCII');
            fprintf(app.handle_lcr, 'OUTP:HPOW ON');        % BIAS OPTION ON
            fprintf(app.handle_lcr, 'TRIG:SOUR BUS');       % GPIB TRIGGER MODE
            fprintf(app.handle_lcr, 'DISP:PAGE MEAS');
            fprintf(app.handle_lcr, 'APER MED');           % SET INTEGRATION TIME TO MED

            % If the connection was opened turn the lamp green
            app.LCRLamp.Color = [0 1 0];

        catch err
            fprintf('Error connecting LCR meter:\n');
            fprintf(err.message);
            fprintf('\n');
            getReport(err)
            success = 0;
        end
    end

    
    
    
    
     if (success) 
        app.AcquisitionPanel.Visible    = 'on';
        app.GraphsPanel.Visible         = 'on';
        app.CorrectionsPanel.Visible    = 'on';
        app.PowerSwitch.Value           = 'On';
     else 
         DisconnectDevices(app);
     end
 
end

