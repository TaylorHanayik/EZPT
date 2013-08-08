function feedbackScreen(params,img)
%feedbackBeta(picdir, win, rect, posimg, pdur)

esc=KbName('ESCAPE');
pdur = params.feedbktime;

vertsize=330;
horizsize=330;
[imgtexture] = textures_from_one_pic(params, img);

[position] = one_pic_destination(params,vertsize,horizsize);
position = (position)';
finalposition = CenterRectOnPoint(position,params.X,params.Y);
%Screen('DrawTextures', params.win, imgtexture, [], params.picRect);
Screen('DrawTextures', params.win, imgtexture, [], finalposition);
%Screen('DrawLines', windowPtr, xy [,width] [,colors] [,center] [,smooth]);
%Screen('DrawLines', win,vertline,3,[0 134 246 ]);
%Screen('DrawLines', win,horzline,3,[0 134 246 ]);
%Screen('DrawLines', win,diag,2);
Screen('Flip', params.win);
RestrictKeysForKbCheck(esc);
Computer_time = GetSecs;
[secs, keyCode] = KbWait([],0, pdur+Computer_time);
if keyCode(esc)
    sca;
    RestrictKeysForKbCheck([]);
end
%pause(pdur);
RestrictKeysForKbCheck([]);
Screen('Close',imgtexture);
% Screen('Close');