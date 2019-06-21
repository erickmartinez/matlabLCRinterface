function loadStateLCR(app)
    fileName = 'stateLCR.mat';
    if exist(fileName)
        load(fileName);
        if strcmp(stateLCR.Path,'')
            app.DirectoryTextArea.Value = pwd;
        else
            app.DirectoryTextArea.Value = stateLCR.Path;
        end
            state.FileTag   = app.FileTagEditField.Value;
            state.Freq      = app.FrequencyHzEditField.Value;
            state.BiasStart = app.BiasStartVEditField.Value;
            state.BiasStop  = app.BiasStopVEditField.Value;
            state.BiasStep  = app.BiasStepVEditField.Value;
            state.Cox       = app.TestCoxFEditField.Value;
            state.Level     = app.LevelVEditField.Value;
            state.IntTime   = app.IntegrationTimeDropDown.Value;
            state.AvgRate   = app.AvgRateDropDown.Value;
            msg = fprintf('loaded state values for %s',state.Cox);
            logMessage(app,msg);
        delete(fileName);
    end
end