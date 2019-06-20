function LCR_setIntegrationTime(app,timeStr,AvgRate)
% Setting integration time and averaging rate for sample
    fprintf(app.handle_lcr, 'APER %s,%d',upper(timeStr),AvgRate);
end