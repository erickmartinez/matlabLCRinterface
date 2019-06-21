function buttonHandle = getButtonHandle(app,pinNumber)
% This function returns the button handler in the GUI for the selected pin
% number
% Get the handle to the background color for the selected pin
    buttonHandle = 0;
    switch(pinNumber)
        case 1
            buttonHandle = app.P1Button;
        case 2
            buttonHandle = app.P2Button;
        case 3
            buttonHandle = app.P3Button;
        case 4
            buttonHandle = app.P4Button;
        case 5
            buttonHandle = app.P5Button;
        case 6
            buttonHandle = app.P6Button;
        case 7
            buttonHandle = app.P7Button;
        case 8
            buttonHandle = app.P8Button;
    end
end