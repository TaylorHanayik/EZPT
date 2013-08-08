function clicks=buttonclickMiddle(picdir, win, rect, posimg, pdur)

if nargin < 1
    picdir = 'C:\Users\Research\Documents\Studies\Iceland\pictures\';
end
if nargin < 2
    background=[0, 0, 0];
    screen=max(Screen('Screens'));
    [win, rect]=Screen('OpenWindow', screen, background);
end

if nargin < 4
    posimg = imread(sprintf('%snopic.jpg', picdir));
end
if nargin < 5
    pdur=0.5;
end
KbName('UnifyKeyNames');
esc=KbName('ESCAPE');
%ent = KbName('RETURN');

winWidth = rect(3);
winHeight = rect(4);
% vertline = [620 620    %X
%             20 680];  %Y
% horzline = [620 1300
%             680 680];
% % center = [620
% %           680];
% diag = [620 1000
%         680 60];
    

vertsize=330;
horizsize=330;
[feedback_textures] = textures_from_one_pic(win, posimg);

[feedback_destinations] = one_pic_destination(winWidth, winHeight,vertsize,horizsize);

Screen('DrawTextures', win, feedback_textures, [], feedback_destinations);
%Screen('DrawLines', windowPtr, xy [,width] [,colors] [,center] [,smooth]);
%Screen('DrawLines', win,vertline,3,[0 134 246 ]);
%Screen('DrawLines', win,horzline,3,[0 134 246 ]);
%Screen('DrawLines', win,diag,2);
Screen('Flip', win);
[clicks,x,y,whichButton] = GetClicks;
if clicks==0
    clicks=1;
end

% RestrictKeysForKbCheck(esc);
% Computer_time = GetSecs;
% [secs, keyCode] = KbWait([],0, pdur+Computer_time);
% if keyCode(esc)
%     sca;
%     RestrictKeysForKbCheck([]);
% end
% %pause(pdur);
% RestrictKeysForKbCheck([]);
Screen('Close',feedback_textures);

% Screen('Close');