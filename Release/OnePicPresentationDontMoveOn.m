function [piconset,response,reactiontime,reject,picOffset] = OnePicPresentationDontMoveOn(params, img, dur,acceptResponses)

if nargin < 3
    dur=1;
end

if acceptResponses == 0
    
    esc=KbName('ESCAPE');
    ent = KbName('RETURN');
    
    [imgtexture] = textures_from_one_pic(params, img);
    Screen('DrawTextures', params.win, imgtexture, [], params.picRect);
    
    [vbl,piconset] = Screen('Flip', params.win);
    RestrictKeysForKbCheck([esc, ent]);
    Computer_time = GetSecs;
    [secs, keyCode] = KbWait([],2, dur+Computer_time);
    if keyCode(esc)
        sca;
        RestrictKeysForKbCheck([]);
    end
    response = 0;
    reactiontime = -999;
    reject = 0;
    RestrictKeysForKbCheck([]);
    Screen('Close',imgtexture);
    
elseif acceptResponses == 1
    
    
    [imgtexture] = textures_from_one_pic(params, img);
    
    %[position] = one_pic_destinationBeta(params,vertsize,horizsize);
    
    %Screen('DrawTextures', params.win, imgtexture, [], position);
    Screen('DrawTextures', params.win, imgtexture, [], params.picRect);
    
    [vbl,piconset] = Screen('Flip', params.win);
    [response, reactiontime, reject] = KeyBoardResponseDontMoveOn(dur);
    
    Screen('Close',imgtexture);
    RestrictKeysForKbCheck([]);
end
picOffset = GetSecs;