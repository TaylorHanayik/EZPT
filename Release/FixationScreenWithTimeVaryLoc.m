function [fixon, fixoff] = FixationScreenWithTimeVaryLoc(params,t) %input is window pointer

period = params.fixperiod;
%Screen('Flip',params.win);
%Screen('FillRect', win);
Screen('TextSize', params.win, params.fixsize);

%DrawFormattedText(params.win, '+' , 'center', 'center',[0 134 246 ], 50);
DrawFormattedText(params.win, '+' , params.X+params.rX(t), params.Y+params.rY(t) ,params.TextColor, 50);
                       %fix   Xpos      Ypos      Color
[vbl, fixon] = Screen('Flip',params.win);
%pause(period)
fixoff = WaitSecs('UntilTime',GetSecs+period);
%fixoff = GetSecs;