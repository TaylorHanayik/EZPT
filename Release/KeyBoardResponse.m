function [response, reactiontime, reject] = KeyBoardResponse(period)
if nargin < 1
    period = 2; %period is the time to wait for response (in secs)
end
KbName('UnifyKeyNames'); %macOS keyboard, makes code portable
DisableKeysForKbCheck(KbName('space')); % so that MRI pulse does not interupt
esc=KbName('ESCAPE'); % for escaping the experiment during stims
 k1 = KbName('1!');
 k2 = KbName('2@');
 k3 = KbName('3#');
 RestrictKeysForKbCheck([k1,k2,k3,esc]);
%period = 4;
Computer_time = GetSecs;
time = KbWait([],0, period+Computer_time);
wait_time = time - Computer_time;
if wait_time > period
    response = 0;
    reactiontime = 9999;
    reject = 1;
else
    [keyIsDown, secs, keyCode]=KbCheck;
    if (keyIsDown==1)
        % Abort requested?
        if keyCode(esc)
            % This signals abortion:
            sca;
            % Break out of display loop:
        end;

        % one key pressed to indicate detection of event?
        if keyCode(KbName('1!')) || keyCode(KbName('1'))
            response=1;
            reactiontime=secs; % subtract your stim onset or other value
            reject=0;             % to truely calculate reaction time, this is simply the time in secs
        end                       % since system start up

        if keyCode(KbName('2@')) || keyCode(KbName('2'))
            response=2;
            reactiontime=secs;
            reject=0;

        end;
        
        if keyCode(KbName('3#')) || keyCode(KbName('3'))
            response=3;
            reactiontime=secs;
            reject=0;

        end;
        
        if keyCode(KbName('4$')) || keyCode(KbName('4'))
            response=3;
            reactiontime=secs;
            reject=0;

        end;
        
        if keyCode(KbName('5%')) || keyCode(KbName('5'))
            response=3;
            reactiontime=secs;
            reject=0;

        end;
        
        if keyCode(KbName('6^')) || keyCode(KbName('6'))
            response=3;
            reactiontime=secs;
            reject=0;

        end;
        
        if keyCode(KbName('7&')) || keyCode(KbName('7'))
            response=2;
            reactiontime=secs;
            reject=0;

        end;
        
        if keyCode(KbName('8*')) || keyCode(KbName('8'))
            response=1;
            reactiontime=secs;
            reject=0;

        end;
        
        if keyCode(KbName('9(')) || keyCode(KbName('9'))
            response=1;
            reactiontime=secs;
            reject=0;

        end;
    end
end
RestrictKeysForKbCheck([]);
DisableKeysForKbCheck([]);