function loadStateLCR(app)
% This function loads all the parameters in the acquisition panel to be
% from the mat file 'stateLCR.mat'
% Parameters
% ----------
% app : obj
%   A handle to the app designer GUI instance

    fileName = 'stateLCR.mat';
    if exist(fileName)
        try
            load(fileName);
            if strcmp(state.Path,'')
                app.DirectoryTextArea.Value = pwd;
            else
                app.DirectoryTextArea.Value       = state.Path;
            end
            app.FiletagEditField.Value        = state.FileTag;
            app.FrequencyHzEditField.Value    = state.Freq;
            app.BiasStartVEditField.Value     = state.BiasStart; 
            app.BiasStopVEditField.Value      = state.BiasStop;
            app.BiasStepVEditField.Value      = state.BiasStep;
            app.TestCoxFEditField.Value       = state.Cox;
            app.LevelVEditField.Value         = state.Level;
            app.IntegrationTimeDropDown.Value = state.IntTime;
            app.AvgRateDropDown.Value         = state.AvgRate;
            app.activePins                    = state.activePins;
            for pin=1:8
                togglePinState(app,pin,state.activePins(pin));
            end

            fprintf('loaded state values from previous measurement.\n');
            delete(fullfile(pwd,fileName));
        catch err
            fprintf(err.message);
            fprintf('\n');
        end
    end
end