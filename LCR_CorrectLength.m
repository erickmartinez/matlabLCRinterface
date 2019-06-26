function LCR_CorrectLength(app)
    logMessage(app,'Performing length comensation');
    modeType    = app.ModeDropDown.Value;
    fprintf(app.handle_lcr, 'FUNC:IMP %s',modeType);
    freq    = app.FrequencyHzEditField.Value;
   
    length  = app.LengthEditField.Value;
    if length < 1
        slength = '0';
    elseif 1 <= length && length < 1.5
        slength = sprintf('0');
    elseif 1.5 <= length && length < 2.5
        slength = sprintf('1M');
    elseif 2.5 <= length && length< 3.5
        slength = sprintf('2M');
    else 
        slength = sprintf('4M');
    end
    

%     fprintf(app.handle_lcr,'CORR:LOAD:TYPE %s',mode);
    fprintf(app.handle_lcr,'DISP:PAGE CSETUP');                 % GO TO THE CORRECTION SETUP PAGE
    fprintf(app.handle_lcr,'CORR:LENG %s',slength);  % CABLE LENGTH X, 
    fprintf(app.handle_lcr,'CORR:METH SING'); %SINGLE COMPEN MODE
    fprintf(app.handle_lcr,'CORR:SPOT1:FREQ %s;STAT ON',getFrequencyString(freq)); % SPOT FREQ 1
%     fprintf(app.handle_lcr,'CORR:SPOT2:FREQ %s;STAT ON',getFrequencyString(freq2)); % SPOT FREQ 2
%     fprintf(app.handle_lcr,'CORR:SPOT3:FREQ %s;STAT ON',getFrequencyString(freq3)); % SPOT FREQ 3
    fprintf(app.handle_lcr,'CORR:LOAD:STAT OFF');               % LOAD COMPEN OFF
end
