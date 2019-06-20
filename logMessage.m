function logMessage(app,msg)
% This function prints a message with a timestamp included
% Parameters
% ----------
% app : obj
%   A handle to the app designer GUI instance
% msg : str
%   The message to be logged
    % Get the file to append the messages to
    path = app.DirectoryTextArea.Value;
    filename = fullfile(path,strcat(app.FiletagEditField.Value,'.log'));
    ts = datestr(now,'yyyy/mm/dd HH:MM:SS');
    msgWithTS = sprintf('%s - %s\n',ts,msg);
    fprintf(msgWithTS);
    % Append the message to the logfile
    % open the file in append mode
    fh = fopen(filename, 'a+');
    fprintf(fh,msgWithTS);
    fclose(fh);
end