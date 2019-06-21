function DisconnectDevices(app)
% Close all connections and reset instruments
% Parameters
% ----------
% app : obj
%   A handle to the GUI instance

    if isprop(app.handle_arduino,'Port')  
        a = app.handle_arduino;
        clear a;
        app.handle_arduino = 0;
    end
    % Reset all connactions
    instrreset;
    app.handle_lcr                  = 0;
    app.AcquisitionPanel.Visible    = 'off';
    app.GraphsPanel.Visible         = 'off';
    app.CorrectionsPanel.Visible    = 'off';
    app.LCRLamp.Color               = [0.149 0.149 0.149];
    app.ArduinoLamp.Color           = [0.149 0.149 0.149];
    app.PowerSwitch.Value           = 'Off';
end