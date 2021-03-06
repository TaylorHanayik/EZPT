function [onsettime, secs, code] = ShowOnePicWithSound(params, img, wavname)

dur = params.displaydur;

esc=KbName('ESCAPE');
ent = KbName('RETURN');
space=KbName('space');


[imgtexture] = textures_from_one_picBeta(params, img);

%[position] = one_pic_destinationBeta(params,vertsize,horizsize);

%Screen('DrawTextures', params.win, imgtexture, [], position);
Screen('DrawTextures', params.win, imgtexture, [], params.picRect);

Screen('Flip', params.win);
onsettime = GetSecs;
code = -1;

PlayAudioSimple(wavname)

RestrictKeysForKbCheck([esc,...
    ent,...
    space,...
    KbName('1'),...
    KbName('1!'),...
    KbName('2'),...
    KbName('2@'),...
    KbName('3'),...
    KbName('3#'),...
    KbName('4'),...
    KbName('4$'),...
    KbName('5'),...
    KbName('5%'),...
    KbName('6'),...
    KbName('6^'),...
    KbName('7'),...
    KbName('7&'),...
    KbName('8'),...
    KbName('8*'),...
    KbName('9'),...
    KbName('9(')]);
Computer_time = GetSecs;
[secs, keyCode] = KbWait([],2, dur+Computer_time);
if keyCode(esc)
    sca;
    RestrictKeysForKbCheck([]);
end
if keyCode(KbName('1')) || keyCode(KbName('1!'))
    code=1;
end
if keyCode(KbName('2')) || keyCode(KbName('2@'))
    code=2;
end;
if keyCode(KbName('3')) || keyCode(KbName('3#'))
    code=3;
end;
if keyCode(KbName('4')) || keyCode(KbName('4$'))
    code=4;
end;
if keyCode(KbName('5')) || keyCode(KbName('5%'))
    code=5;
end;
if keyCode(KbName('6')) || keyCode(KbName('6^'))
    code=6;
end;
if keyCode(KbName('7')) || keyCode(KbName('7&'))
    code=7;
end;
if keyCode(KbName('8')) || keyCode(KbName('8*'))
    code=8;
end;
if keyCode(KbName('9')) || keyCode(KbName('9('))
    code=9;
end;

RestrictKeysForKbCheck([]);
Screen('Close',imgtexture);