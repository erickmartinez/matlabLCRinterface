function LCR_setFrequency(app,freq)
    sFreq = sprintf('FREQ %dHz',freq);
    if freq < 1000
        sFreq = sprintf('FREQ %dHz',freq);
    elseif 1000 <= freq && freq < 1e6
        sFreq = sprintf('FREQ %dKHz', (freq/1000));
    elseif freq >= 1e6
        sFreq = sprintf('FREQ %dMHz', (freq/1e6));
    end
    fprintf(app.handle_lcr,sFreq);