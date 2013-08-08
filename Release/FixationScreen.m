function FixationScreen(params) %input is window pointer

period = params.fixperiod;
Screen('Flip',params.win);
%Screen('FillRect', win);
Screen('TextSize', params.win, params.fixsize);
%DrawFormattedText(params.win, '+' , 'center', 'center',[0 134 246 ], 50);
DrawFormattedText(params.win, '+' , 'center', 'center',params.TextColor, 50);
                       %fix   Xpos      Ypos      Color
Screen('Flip',params.win);
pause(period)