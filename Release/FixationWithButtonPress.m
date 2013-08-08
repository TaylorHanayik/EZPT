function FixationWithButtonPress(params) 

esc=KbName('ESCAPE');
ent = KbName('RETURN');
space=KbName('space');
Screen('Flip',params.win);
Screen('TextSize', params.win, params.fixsize);
DrawFormattedText(params.win, '+' , 'center', 'center',params.TextColor, 50);
                       %fix   Xpos      Ypos      Color
Screen('Flip',params.win);
RestrictKeysForKbCheck([esc, ent, space]);
[secs, keyCode] = KbWait([],2);
if keyCode(esc)
    sca;
    RestrictKeysForKbCheck([]);
end  

RestrictKeysForKbCheck([]);