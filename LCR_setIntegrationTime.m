function LCR_setIntegrationTime(app,timeStr,AvgRate)
% This function sets the integration time and averaging rate for
% capacitance measurement
% Parameters
% ----------
% app : obj
%   The handle to the app designer GUI instance
% timeStr : string
%   The integration time: SHORT, MEDIUM or LONG
% AvgRate : integer
%   The averaging rate : 1,2,4,8,16,32,64,128
    query = sprintf('APER %s,%d',upper(timeStr),AvgRate);
    fprintf(app.handle_lcr,query);
end