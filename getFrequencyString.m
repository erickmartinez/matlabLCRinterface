function [sFreq] = getFrequencyString(freq)
    sFreq = sprintf('%dHz',freq);
    if freq < 1000
        sFreq = sprintf('%dHz',freq);
    elseif 1000 <= freq && freq < 1e6
        sFreq = sprintf('%dKHz', (freq/1000));
    elseif freq >= 1e6
        sFreq = sprintf('%dMHz', (freq/1e6));
    end
end