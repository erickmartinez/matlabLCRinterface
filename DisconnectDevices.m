function DisconnectDevices(app)
% Close all connections and reset instruments
% Parameters
% ----------
% app : obj
%   A handle to the GUI instance
    % Close the connection to the arduino
    fclose(app.h_arduino);
    app.h_arduino                   = 0;
    % Reset all connactions
    instrreset;
    app.AcquisitionPanel.Visible    = 'off';
    app.GraphsPanel.Visible         = 'off';
    app.CorrectionsPanel.Visible    = 'off';
    app.LCRLamp.Color               = [0.149 0.149 0.149];
    app.ArduinoLamp.Color           = [0.149 0.149 0.149];
end