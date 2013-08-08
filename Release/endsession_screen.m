function endsession_screen(params, endtxt, waitmode)
%function Thank_you_screen(win, background, expdir)
Screen('Flip',params.win);
Screen('TextFont',params.win, params.font);
Screen('TextSize',params.win, 30);
Screen('TextStyle', params.win, 1);
esc=KbName('ESCAPE');
ent = KbName('RETURN');
space = KbName('space');
RestrictKeysForKbCheck([esc, ent, space]);
% Read some text file:
% fd = fopen(sprintf('%sThankyou.txt',expdir));
fd = fopen(endtxt);
if fd==-1
    error('Could not open end session file!');
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
%Screen('FillRect', win, background)
DrawFormattedText(params.win, mytext, 'center', 'center', params.TextColor, 0);
%txt     Xpos       Ypos    Color     Char/line
Screen('Flip',params.win);
if waitmode==0 %waits for duration of 'pdur' then proceeds 
    pdur=params.pdur;
    Computer_time = GetSecs;
    [secs, keyCode] = KbWait([],0, pdur+Computer_time);
    if keyCode(esc)
        sca;
        RestrictKeysForKbCheck([]);
    end
elseif waitmode==1 %waits for 'ENTER' to be pressed
    [secs, keyCode] = KbWait([],2);
    if keyCode(esc)
        sca;
        error('Escape was pressed');
        RestrictKeysForKbCheck([]);
    end
    if keyCode(ent)| keyCode(space)
        RestrictKeysForKbCheck([]);
    end
end