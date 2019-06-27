function StartMeasurement(app)
% Starts the acquisition
% Parameters
% ----------
% app : obj
%   A handle to the app designer GUI instance

    % Start the measurement only if the start button has the value set to
    % 'Start'.
    if strcmp(app.StartButton.Text,'Start') 
        % Turn the acquisition flag to 1 
        app.acquisitionFlag = 1;
        % Get the path to save the data from the GUI
        path = app.DirectoryTextArea.Value;
        % Check that the path is not empty
        if (strcmp(path,'') || isempty(path))
            % If the path is empty, then stop and send a warning message.
            app.acquisitionFlag = 0;
            warndlg('Choose a directory to save the output');
        end
        % Get the file tag from the GUI
        filetag = app.FiletagEditField.Value;
        if (strcmp(filetag,'') || isempty(filetag))
            % If the file tag is empty, then stop the acquisition and send
            % a warning.
            app.acquisitionFlag = 0;
            warndlg('Choose a file tag to save the output');
        end
        
        % Get the acquisition parameters
        biasStart   = app.BiasStartVEditField.Value;      % V
        biasStop    = app.BiasStopVEditField.Value;       % V
        biasStep    = app.BiasStepVEditField.Value;       % V
        freq        = app.FrequencyHzEditField.Value;     % Hz
        level       = app.LevelVEditField.Value;          % V
        delayTime   = 0.1;                                % s
        holdTime    = 10;                                 % s
        intTime     = app.IntegrationTimeDropDown.Value;
        avgRate     = str2num(app.AvgRateDropDown.Value); 
        modeType    = app.ModeDropDown.Value;
        
        % The worst case accuracy of the LCR
        basicAccuracyC = 0.05;                           % percent
        basicAccuracyV = 0.1;                            % percent
        
        % Get the step with the sign depending on the direction of the
        % bias sweep.
        step        = (biasStop-biasStart)/abs(biasStop-biasStart)*biasStep;
        % Construct an array of bias points
        V           = biasStart:step:biasStop;
        V_err       = V*basicAccuracyV/100;
        NPOINTS     = length(V);
        % Number of active pins and indices of the active pins
        [NPINS,pinIndex] = NPinsIdentifier(app);
        
        % Define a color palette for the pins
        cp = cool(NPINS);
        % Define an array of linespec
        ls = ['o','s','d','^','v','>','<','p'];
         
        
        
        % If all the checks on the acquisition parameters pass, execute the
        % measurement
        if (app.acquisitionFlag == 1)
            app.stopFlag = 0;
            % Change the Start button label
            app.StartButton.Text  = 'Running';
            app.StartButton.BackgroundColor = [0 1 0];
            
            logMessage(app,'********** Starting measurement ***********');
            % Log the acquisition parameters
            msg_bias    = sprintf('Bias start = %.4f V, step = %.4f V end %.4f V',...
                biasStart,biasStep,biasStop);
            msg_npoints = sprintf('Number of bias points = %d',NPOINTS);
            msg_pins    = sprintf('Active pins      = %s',strjoin(string(pinIndex),','));
            msg_freq    = sprintf('Frequency        = %.3e Hz',freq);
            msg_lvl     = sprintf('Osc level        = %.3f V',level);
            msg_delay   = sprintf('Delay time       = %.3f s',delayTime);
            msg_holdt   = sprintf('Hold time        = %.3f s',holdTime);
            msg_intt    = sprintf('Integration time = %s',intTime);
            msg_avgR    = sprintf('Average rate     = %d',avgRate);
            msg_mode    = sprintf('Mode type        = %s',modeType);
            
            
            logMessage(app,msg_bias);
            logMessage(app,msg_npoints);
            logMessage(app,msg_pins);
            logMessage(app,msg_freq);
            logMessage(app,msg_lvl);
            logMessage(app,msg_delay);
            logMessage(app,msg_holdt);
            logMessage(app,msg_intt);
            logMessage(app,msg_avgR);
            logMessage(app,msg_mode);
            
            
            % pre-allocate depending on number of active pins
            C       = NaN(NPOINTS,NPINS);   % Capacitance matrix
            C_err   = NaN(NPOINTS,NPINS);   % Capacitance error matrix
            R       = NaN(NPOINTS,NPINS);   % Resistance matrix
            R_err   = NaN(NPOINTS,NPINS);   % Resistance error matrix
            Current = NaN(NPOINTS,NPINS);   % AC current matrix
            legStr  = string(NPINS);          % A matrix with the pin labels
            plotHandles = NaN(NPINS,1);

            
            fprintf(app.handle_lcr, 'MEM:DIM DBUF,%d',1);   % DEFINE BUFFER IN 4284A
            fprintf(app.handle_lcr, 'MEM:FILL DBUF');       % ENABLE BUFFER TRANSFER
            % Set the osc voltage level in the LCR
            LCR_OSC_Level(app,level);
            % Set the delay time between points
            LCR_setDelayTime(app,delayTime);
            % Set the frequency on the LCR
            LCR_setFrequency(app,freq); 
            % Set the integration time
            LCR_setIntegrationTime(app,intTime,avgRate);
            % Set the acquisition mode
            fprintf(app.handle_lcr, 'FUNC:IMP %s',modeType);
            % Set the active page in the LCR meter to measurement
            fprintf(app.handle_lcr, 'DISP:PAGE MEAS');
            % Turn on bias
            fprintf(app.handle_lcr,'BIAS:STATE ON');
            % Define the time
            totTime = 0;
            
            % Clear the axes
            cla(app.CVAxes);
            % Set the axes to hold the plots
            hold(app.CVAxes,'on');
            
            
            % Create a label for the plot
            for i = 1:NPINS
                % Create the plot with data sources
                phandle = errorbar(app.CVAxes,V,C(:,i),C_err(:,i),...
                    ls(i),'Color',cp(i,:));
                phandle.YDataSource = 'C(:,i)';
                phandle.YNegativeDeltaSource  = 'C_err(:,i)';
                phandle.YPositiveDeltaSource  = 'C_err(:,i)';
                phandle.XNegativeDeltaSource  = 'V_err';
                phandle.XPositiveDeltaSource  = 'V_err';
                plotHandles(i) = phandle;
                legStr(i) = sprintf('Pin %d',pinIndex(i));
            end
            legend(app.CVAxes,legStr);
            legend(app.CVAxes,'Location','northeast');
            legend(app.CVAxes,'boxoff');
            drawnow;
            
            for i = 1:NPINS
                selectedPin = pinIndex(i);
                
                % Turn the pin on
                turnArduinoPinOn(app,selectedPin);
                logMessage(app,sprintf('Setting the bias to %.4f V',V(1)));
                fprintf(app.handle_lcr,'BIAS:VOLT %.5f',V(1));
                logMessage(app,sprintf('Holding time = %.1f s',holdTime));
                pause(holdTime);
                logMessage(app,sprintf('Starting measurements on pin %d',selectedPin));
                for j=1:NPOINTS
                    % Count the time between the measurements and estimate
                    % the sweep rate
                    tstart = tic;
                    % Update the data point and pin progress
                    dataProgress_txt    = sprintf("%d/%d",j,NPOINTS);
                    pinProgress_txt     = sprintf("%d/%d",i,NPINS);
                    app.DatapointEditField.Value    = dataProgress_txt;
                    app.PinEditField.Value          = pinProgress_txt;
                    % Update the bias field in the GUI
                    app.BiasVEditField.Value        = V(j);
                    % Set the bias
                    fprintf(app.handle_lcr,'BIAS:VOLT %.5f',V(j));
                    % Trigger the measurement
                    fprintf(app.handle_lcr,'TRIG');
                    % Fetch the result
                    fprintf(app.handle_lcr,'FETC?');
                    % Bring the results from the LCR (in ASCII mode)
                    d0   = fscanf(app.handle_lcr);
                    % Get the data in matrix form
                    data = sscanf(d0,'%e,%e,%d',[3,1]);
                    C(j,i) = data(1);
                    R(j,i) = data(2);
                    % Estimate the error of the capacitance
                    C_err(j,i) = basicAccuracyC*C(j,i)/100;
                    % Estimate the error of the resitance
                    R_err(j,i) = basicAccuracyC*R(j,i)/100;
                    % Clear the buffer in the LCR meter
                    fprintf(app.handle_lcr,'MEM:CLE DBUF;FILL DBUF');
                    % Read the latest measured ac current
                    fprintf(app.handle_lcr,'FETC:SMON:IAC?');
                    i0              = fscanf(app.handle_lcr);
                    Current(j,i)    = str2double(i0);
                    % Clear the buffer again
                    fprintf(app.handle_lcr,'MEM:CLE DBUF;FILL DBUF');
                    clrdevice(app.handle_lcr);
                    % Estimate the elapsed time, total time and sweep rate
                    elapsedTime = toc(tstart);
                    totTime     = totTime + elapsedTime;
                    sweepRate   = biasStep/elapsedTime;
                    
                    app.CapacitanceEditField.Value  = C(j,i);
                    app.SweeprateEditField.Value    = sweepRate;
                    app.ElapsedTimeEditField.Value  = totTime;
                    
                    plot_handle = plotHandles(i);
                    % Add the point to the plot
                    refreshdata(plot_handle,'caller');
                    drawnow
                    
                    pause(0.0001);
                    % If the abort button was pushed, it will change the
                    % stopFlag to 1 and stop collecting data
                    if app.stopFlag ~= 0
                        break
                    end
                end % for j=1:NPOINTS
                logMessage(app,'Clearing the buffer');
                fprintf(app.handle_lcr,'MEM:CLE DBUF;FILL DBUF');
                logMessage(app,'Setting the bias to 0.0 V');
                fprintf(app.handle_lcr,'BIAS:VOLT 0 V');
                if app.stopFlag ~= 0
                    break
                end
            end % j=1:NPOINTS
            % Turn all pins off
            logMessage(app,'Disconnecting all pins.');
            turnArduinoPinsOff(app);
            % Set the hold off on the axes
            hold(app.CVAxes,'off');
            % Turn off bias
            fprintf(app.handle_lcr,'MEM:CLE DBUF;FILL DBUF');
%             fprintf(app.handle_lcr,'BIAS:VOLT 0 V');
            fprintf(app.handle_lcr,'BIAS:STATE OFF');
            
            
            % SAVE DATA
            if app.stopFlag == 0
                logMessage(app,'Saving the data.');
                fulltag     = strcat(filetag,'-',TimeStamp);
                filename    = fullfile(path{1},fulltag);
                saveFigure(app,filename,V,C,C_err,legStr);
                % Save the configuration
                state = saveStateLCR(app);
                save(strcat(filename,'.mat'),'V','V_err','C','C_err',...
                    'R','R_err','freq','pinIndex','state');

            end % if app.stopFlag == 0
            
            if strcmp(app.StartButton.Text, 'Running')
                app.StartButton.Text = 'Start';
                app.StartButton.BackgroundColor = [0.96 0.96 0.96];
                app.acquisitionFlag = 0;
            end
            
        end % if (app.acquisitionFlag == 1)
        
    end % if app.StartButton.Text == 'Start' 
end


