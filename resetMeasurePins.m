function resetMeasurePins(app,resetButtonState)
% Turn all measurement pins off or on depending on the state of the reset
% button
   
    if strcmp(resetButtonState,'On')
       for i = 1:8 
           bh = getButtonHandle(app,i);
           bh.Value = 1;
           togglePinState(app,i,1);
       end
    else 
        for i = 1:8 
           bh = getButtonHandle(app,i);
           bh.Value = 0;
           togglePinState(app,i,0);
        end
    end
end