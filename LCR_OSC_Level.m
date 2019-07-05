function LCR_OSC_Level(app,lev)
    % Set the OSC LEVEL 
    fprintf(app.handle_lcr,'VOLT:LEV %.4fV',lev)
end