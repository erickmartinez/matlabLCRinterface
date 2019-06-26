function LCR_ShortCompen(app)
    logMessage(app,'Performing short comensation');
    mode = app.ModeDropDown.Value;
    for i=2:9
        toggleArduinoPin(app,i,1);
    end
    fprintf(app.handle_lcr,'DISP:PAGE CSETUP');
    fprintf(app.handle_lcr,'CORR:LOAD:TYPE %s',mode);
    fprintf(app.handle_lcr,'CORR:SPOT1:SHORT');
    fprintf(app.handle_lcr,'CORR:SPOT2:SHORT');
    fprintf(app.handle_lcr,'CORR:SPOT3:SHORT');
    fprintf(app.handle_lcr,'*OPC?');
    out = fscanf(app.handle_lcr);
    msg = sprintf('Short correction output : %s',out);
    logMessage(app,msg);
    fprintf(app.handle_lcr,'CORR:SHORT:STAT ON');
    turnArduinoPinsOff(app);
%     fprintf(app.handle_lcr,'LOAD:STAT OFF');
%     app.handle_lcr.Timeout = 10;%  timeout value of 10 seconds is used.
end