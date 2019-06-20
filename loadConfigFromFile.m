function loadConfigFromFile(app,file,path)
    fileName = fullfile(path,file);
    if isfile(fileName)
        mf = matfile(fileName);
        try
            state = mf.state;
        
            if strcmp(state.Path,'')
                app.DirectoryTextArea.Value     = pwd;
            else
                app.DirectoryTextArea.Value     = state.Path;
            end
            app.FiletagEditField.Value      = state.FileTag;
            app.FrequencyHzEditField.Value  = state.Freq;
            app.BiasStartVEditField.Value   = state.BiasStart;
            app.BiasStopVEditField.Value    = state.BiasStop;
            app.BiasStepVEditField.Value    = state.BiasStep;
            app.LengthEditField.Value       = state.Length;
            app.RepetitionsEditField.Value  = state.Averages;
            app.TestCoxFEditField.Value     = state.Cox;
        catch err
            err_msg = strrep(getReport(err), '\', '\\');
            fprintf('Error loading values.\n');
            fprintf('\n');
            fprintf(err_msg);
        end
    else
        fprintf('Could not load the file.\n');
    end
end