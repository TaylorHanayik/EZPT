function [vidonset,grabber] = videoplaywhilerecord_fcn_test(params, recordname, scriptvid)

fprintf('Recording to movie file %s ...\n', recordname);
withsound = 86;
% Initial flip to a blank screen:
Screen('Flip',params.win);
grabber = Screen('OpenVideoCapture', params.win, [], [0 0 640 480],[] ,[], [] , params.codec, withsound);
%--- for playing script video
%********************************************************
%
% Open movie file:
movie = Screen('OpenMovie', params.win, scriptvid);
% Start playback engine:
Screen('PlayMovie', movie, 1);
%
%********************************************************
for nreps = 1:1

    % Select a moviename for the recorded movie file:
    recmname = sprintf('SetNewMoviename=%s.mov', recordname);
    Screen('SetVideoCaptureParameter', grabber, recmname);
    Screen('StartVideoCapture', grabber, 30, 1)


    oldtex = 0;
    tex = 0;
    oldpts = 0;
    pts = 0;

    % Run until keypress:
    esc=KbName('ESCAPE');
    RestrictKeysForKbCheck(esc);
    
    vidonset = GetSecs;
    while ~KbCheck

        %WaitSecs('YieldSecs', 0.1);
        %--- for playing script vid also
        %**************************************************************************
        tex = Screen('GetMovieImage', params.win, movie);
        % Valid texture returned? A negative value means end of movie reached:
        if tex<=0
            % We're done, break out of loop:
            break;
        end;
        % Draw the new texture immediately to screen:
        Screen('DrawTexture', params.win, tex,[],params.vidRect);
        % Update display:
        Screen('Flip', params.win);
        % Release texture:
        Screen('Close', tex);
    end
    %**************************************************************************
    % Stop capture engine and recording:
    %Screen('StopVideoCapture', grabber); %9-21-12 TH
end

% Close engine and recorded movie file:
%Screen('CloseVideoCapture', grabber); %9-21-12 TH
Screen('PlayMovie', movie, 0);
% Close movie:
Screen('CloseMovie', movie);