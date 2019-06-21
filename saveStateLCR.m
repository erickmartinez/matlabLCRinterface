function saveStateLCR(app)
    state.Path      = app.DirectoryTextArea.Value;
    state.FileTag   = app.FileTagEditField.Value;
    state.Freq      = app.FrequencyHzEditField.Value;
    state.BiasStart = app.BiasStartVEditField.Value;
    state.BiasStop  = app.BiasStopVEditField.Value;
    state.BiasStep  = app.BiasStepVEditField.Value;
    state.Cox       = app.TestCoxFEditField.Value;
    state.Level     = app.LevelVEditField.Value;
    state.IntTime   = app.IntegrationTimeDropDown.Value;
    state.AvgRate   = app.AvgRateDropDown.Value;
    msg = fprintf('saved state values for %s',state.Cox);
    logMessage(app,msg);
    save('stateLCR.mat','state');
end
    