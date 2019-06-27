function [state] = saveStateLCR(app)
    state.Path       = app.DirectoryTextArea.Value;
    state.FileTag    = app.FiletagEditField.Value;
    state.Freq       = app.FrequencyHzEditField.Value;
    state.BiasStart  = app.BiasStartVEditField.Value;
    state.BiasStop   = app.BiasStopVEditField.Value;
    state.BiasStep   = app.BiasStepVEditField.Value;
    state.Level      = app.LevelVEditField.Value;
    state.IntTime    = app.IntegrationTimeDropDown.Value;
    state.AvgRate    = app.AvgRateDropDown.Value;
    state.activePins = app.activePins;
   
    save('stateLCR.mat','state');
    fprintf('Saved acquisition parameters for this measurement.\n');
end
    