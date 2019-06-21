function LCR_OpenCompen(app)
%     app.handle_lcr.Timeout = 60;%  timeout value of 60 seconds is used.
    mode = 'CPRP';%upper(app.ModeDropDown.Value);
    fprintf(app.handle_lcr,'DISP:PAGE CSETUP');
    fprintf(app.handle_lcr,'CORR:LOAD:TYPE %s',mode);
    fprintf(app.handle_lcr,'CORR:SPOT1:OPEN');
    fprintf(app.handle_lcr,'CORR:SPOT2:OPEN');
    fprintf(app.handle_lcr,'CORR:SPOT3:OPEN');
    fprintf(app.handle_lcr,'*OPC?');
    out = fscanf(app.handle_lcr);
    fprintf(app.handle_lcr,'CORR:OPEN:STAT ON');
%     fprintf(app.handle_lcr,'LOAD:STAT ON');
    sprintf('Open correction output : %s',out);
%     app.handle_lcr.Timeout = 10;%  timeout value of 10 seconds is used.

