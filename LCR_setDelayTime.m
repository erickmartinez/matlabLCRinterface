function LCR_setDelayTime(app,delay)
    fprintf(app.handle_lcr, 'TRIG:DEL %.3f',delay);