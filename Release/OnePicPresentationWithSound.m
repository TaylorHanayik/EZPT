function [onsettime, secs] = OnePicPresentationWithSound(params, img, wavname)

dur = params.picdur;

esc=KbName('ESCAPE');
ent = KbName('RETURN');
space=KbName('space');
    
[imgtexture] = textures_from_one_picBeta(params, img);

%[position] = one_pic_destinationBeta(params,vertsize,horizsize);

%Screen('DrawTextures', params.win, imgtexture, [], position);
Screen('DrawTextures', params.win, imgtexture, [], params.picRect);

Screen('Flip', params.win);
onsettime = GetSecs;

PlayAudioSimple(wavname)

RestrictKeysForKbCheck([esc, ent,space]);
Computer_time = GetSecs;
[secs, keyCode] = KbWait([],2, dur+Computer_time);
if keyCode(esc)
    sca;
    RestrictKeysForKbCheck([]);
end

RestrictKeysForKbCheck([]);
Screen('Close',imgtexture);
