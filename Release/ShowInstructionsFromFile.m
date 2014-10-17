function [start]=ShowInstructionsFromFile(params,instruct)

KbName('UnifyKeyNames');
esc=KbName('ESCAPE');
ent = KbName('RETURN');
space=KbName('space');
%b1 = KbName('1!');
% Select specific text font, style and size:
Screen('TextFont',params.win, params.font);
Screen('TextSize',params.win, params.tsize);
Screen('TextStyle', params.win, 1);
% Read some text file:
fd = fopen(instruct);
if fd==-1
    error('Could not open Instructions file !');
end

mytext = '';
tl = fgets(fd);
lcount = 0;
while (tl~=-1) & (lcount < 48)
    mytext = [mytext tl];
    tl = fgets(fd);
    lcount = lcount + 1;
end
fclose(fd);
mytext = [mytext char(10)];

% mytext contains the content of the first 48 lines of the text file.
% Let's print it: Start at (x,y)=(10,10), break lines after 40
% characters:
%Screen('FillRect', params.win);
Screen('Flip',params.win);
%DrawFormattedText(params.win, mytext, 'center', 'center', [0 134 246 ], 0);
DrawFormattedText(params.win, mytext, 'center', 'center', params.TextColor, 60);
                       %txt     %Xpos      %Ypos    %color    %char/line
Screen('Flip',params.win);
RestrictKeysForKbCheck([esc,ent,space]);
[secs, keyCode] = KbWait;
if keyCode(esc)
    sca;
    RestrictKeysForKbCheck([]);
end    
% if keyCode(ent)
%     start = secs;
RestrictKeysForKbCheck([]);    
% end
    start = secs;