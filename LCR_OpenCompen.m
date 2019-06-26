function LCR_OpenCompen(app)
    logMessage(app,'Performing open comensation');
    mode    = app.ModeDropDown.Value;
    fprintf(app.handle_lcr,'DISP:PAGE CSETUP');
    fprintf(app.handle_lcr,'CORR:LOAD:TYPE %s',mode);
    fprintf(app.handle_lcr,'CORR:SPOT1:OPEN');
%     fprintf(app.handle_lcr,'CORR:SPOT2:OPEN');
%     fprintf(app.handle_lcr,'CORR:SPOT3:OPEN');
    fprintf(app.handle_lcr,'*OPC?');
    out = fscanf(app.handle_lcr);
    fprintf(app.handle_lcr,'CORR:OPEN:STAT ON');
%     fprintf(app.handle_lcr,'LOAD:STAT ON');
    msg = sprintf('Open correction output : %s',out);
    logMessage(app,msg);
end
