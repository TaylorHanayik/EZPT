function code = fixationCode(params) 

esc=KbName('ESCAPE');
ent = KbName('RETURN');
space=KbName('space');
Screen('Flip',params.win);
Screen('TextSize', params.win, params.fixsize);
DrawFormattedText(params.win, '+' , 'center', 'center',params.TextColor, 50);
                       %fix   Xpos      Ypos      Color
Screen('Flip',params.win);
code = -1;
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
[secs, keyCode] = KbWait([],2);
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
% if keyCode(ent)
%     RestrictKeysForKbCheck([]);
% end 
RestrictKeysForKbCheck([]);