function ResponseScreenNoOutput(params)

esc=KbName('ESCAPE');
ent = KbName('RETURN');
%pause(0.5);
per = params.fakerespperiod;
%Screen('FillRect', params.win);
Screen('TextSize', params.win, params.tsize);
Screen('TextFont',params.win, params.font);
Screen('TextStyle', params.win, 1);
DrawFormattedText(params.win, params.fakeprompt , 'center', 'center',params.TextColor, 40);
Screen('Flip',params.win);
RestrictKeysForKbCheck(esc);
Computer_time = GetSecs;
[secs, keyCode] = KbWait([],0, per+Computer_time);
if keyCode(esc)
    sca;
    RestrictKeysForKbCheck([]);
end
RestrictKeysForKbCheck([]);
%pause(per);

