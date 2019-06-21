function LCR_ShortCompen(app)
%     app.handle_lcr.Timeout = 60;%  timeout value of 60 seconds is used.
    mode = 'CPRP';%upper(app.ModeDropDown.Value);
    fprintf(app.handle_lcr,'DISP:PAGE CSETUP');
    fprintf(app.handle_lcr,'CORR:LOAD:TYPE %s',mode);
    fprintf(app.handle_lcr,'CORR:SPOT1:SHORT');
    fprintf(app.handle_lcr,'CORR:SPOT2:SHORT');
    fprintf(app.handle_lcr,'CORR:SPOT3:SHORT');
    fprintf(app.handle_lcr,'*OPC?');
    out = fscanf(app.handle_lcr);
    sprintf('Short correction output : %s',out);
    fprintf(app.handle_lcr,'CORR:SHORT:STAT ON');
%     fprintf(app.handle_lcr,'LOAD:STAT OFF');
%     app.handle_lcr.Timeout = 10;%  timeout value of 10 seconds is used.
