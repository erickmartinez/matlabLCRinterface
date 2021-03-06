function logMessage(app,msg)
% This function prints a message with a timestamp included
% Parameters
% ----------
% app : obj
%   A handle to the app designer GUI instance
% msg : str
%   The message to be logged
    % Get the file to append the messages to
    path = app.DirectoryTextArea.Value{1};
    filename = fullfile(path,strcat(app.FiletagEditField.Value,'.log'));
    if isfile(filename)
        fid  = fopen(filename, 'a+');
    else
        fid  = fopen(filename, 'w');
    end
    ts = datestr(now,'yyyy/mm/dd HH:MM:SS');
    msgWithTS = sprintf('%s - %s',ts,msg);
    fprintf(msgWithTS);
    fprintf('\n');
    % Append the message to the logfile
    % open the file in append mode
    
    fprintf(fid,msgWithTS);
    fprintf(fid,'\r\n');
    fclose(fid);
end