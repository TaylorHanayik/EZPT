function ThankYouScreenFromFile(params, thanks)
%function Thank_you_screen(win, background, expdir)

Screen('Flip',params.win);
Screen('TextFont',params.win, params.font);
Screen('TextSize',params.win, 30);
Screen('TextStyle', params.win, 1);
esc=KbName('ESCAPE');
%ent = KbName('RETURN');
% Read some text file:
% fd = fopen(sprintf('%sThankyou.txt',expdir));
fd = fopen(thanks);
if fd==-1
    error('Could not open thank you file!');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mytext = '';
tl = fgets(fd);
lcount = 0;
while (tl~=-1) & (lcount < 48)
    mytext = [mytext tl];
    tl = fgets(fd);
    lcount = lcount + 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fclose(fd);
mytext = [mytext char(10)];

Screen('Flip',params.win);
%Screen('FillRect', params.win);
%Screen('FillRect', win, background)
%DrawFormattedText(params.win, mytext, 'center', 'center', [0 134 246 ], 0);
DrawFormattedText(params.win, mytext, 'center', 'center', params.TextColor, 0);
%txt     Xpos       Ypos    Color     Char/line
Screen('Flip',params.win);
pdur=2;
RestrictKeysForKbCheck(esc);
Computer_time = GetSecs;
[secs, keyCode] = KbWait([],0, pdur+Computer_time);
if keyCode(esc)
    RestrictKeysForKbCheck([]);
    sca;
end

Screen('CloseAll');
RestrictKeysForKbCheck([]);
% Done with the experiment. Close onscreen window and finish.
ShowCursor;