function [reject,movieduration,fps,framecount,flashOnset,flashOffset,droppedcount,response,reactiontime] = PlayVideoWithResponseEcog(params, moviename)
%
%

% History:
% 12/19/05  mk  Wrote it.
% 02/03/06  mk  Adapted for use on Windows.
% 03/11/12  mk  Cleanup.
% 05/7/12   th  adapted for EZPT


if nargin < 2
    moviename = [ PsychtoolboxRoot 'PsychDemos/QuicktimeDemos/DualDiscs.mov' ];
    %timeOfEvent = 1.16;
end;

% if nargin < 3
%     timeOfEvent = 1.16;
% end;


% Query keycodes for ESCAPE key and Space key:
esc=KbName('ESCAPE');
k1 = KbName('1');
k2 = KbName('2');
k3 = KbName('3');
b1 = KbName('1!');
b2 = KbName('2@');
b3 = KbName('3#');
RestrictKeysForKbCheck([k1,k2,k3,b1,b2,b3,esc]);


% Clear screen to background color:
%Screen('FillRect', params.win);


% Show cleared screen...
Screen('Flip',params.win);

% Main trial loop: Do 'trials' trials...
for i=1
    % Open the moviefile and query some infos like duration, framerate,
    % width and height of video frames. We could also query the total count of frames in
    % the movie, but computing 'framecount' takes long, so avoid to query
    % this property if you don't need it!
    
    [movie movieduration fps] = Screen('OpenMovie', params.win, moviename);%keep only this
    
    
    % We estimate framecount instead of querying it - faster:
    framecount = movieduration * fps;
    
    % Start playback of the movie:
    % Play 'movie', at a playbackrate = 1 (normal speed forward),
    % play it once, aka with loopflag = 0,
    % play audio track at volume 1.0  = 100% audio volume.
    Screen('PlayMovie', movie, 1, 0, 1.0);
    
    % Video playback and key response RT collection loop:
    % This loop repeats until either the subject responded with a
    % keypress to indicate s(he) detected the event in the vido, or
    % until the end of the movie is reached.
    movietexture=0;     % Texture handle for the current movie frame.
    reactiontime=-1;    % Variable to store reaction time.
    lastpts=0;          % Presentation timestamp of last frame.
    onsettime=-1;       % Realtime at which the event was shown to the subject.
    reject=0;      % Flag which is set to 1 to reject an invalid trial.
    
    while(movietexture>=0)%&& reactiontime==-1)
        
        % Check if a new movie video frame is ready for visual
        % presentation: This call polls for arrival of a new frame. If
        % a new frame is ready, it converts the video frame into a
        % Psychtoolbox texture image and returns a handle in
        % 'movietexture'. 'pts' contains a so called presentation
        % timestamp. That is the time (in seconds since start of movie)
        % at which this video frame should be shown on the screen.
        % Arrival of textures is automatically synchronized to the
        % audio track and to real-world time. If the video display loop
        % can't keep up with the flow of time and the soundtrack,
        % quicktime will automatically skip/drop frames to keep video
        % in sync with audio as good as possible. If the pts of a new
        % texture is greater than the 'timeOfEvent' then you'll know
        % that this texture will show the visual target event as soon
        % as you draw and 'Flip' it.
        % In case that no new video texture is available yet for
        % presentation, this function will return a zero texture handle
        % to indicate this. If no new texture will become available
        % anymore, because the end of the movie is reached, it will
        % return a handle of -1 to indicate end of playback.
        
        % The 0 - flag means: Don't wait for arrival of new frame, just
        % return a zero or -1 'movietexture' if none is ready.
        [movietexture pts] = Screen('GetMovieImage', params.win, movie, 0);
        
        % Is it a valid texture?
        if (movietexture>0)
            % Yes. Draw the texture into backbuffer:
            Screen('DrawTexture', params.win, movietexture,[],params.vidRect);
            Screen('FillRect', params.win, params.flashColor, params.stimArea);
            %[oneSecWaitVBL(i,j),oneSecWaitOnset(i,j)] = Screen('Flip',params.win);
            
            % Flip the display to show the image at next retrace:
            % vbl will contain the exact system time of image onset on
            % screen: This should be accurate in the sub-millisecond
            % range.

            [flashOnVBL, flashOnset]=Screen('Flip', params.win);
            
            % Is this the event video frame we've been waiting for?
            if (onsettime==-1) %&& pts >= timeOfEvent)
                % Yes: This is the first frame with a pts timestamp that is
                % equal or greater than the timeOfEvent, so 'vbl' is
                % the exact time when the event was presented to the
                % subject. Define it as onsettime:
                onsettime = flashOnset;
                
                % Compare current pts to last one to see if the movie
                % decoder skipped a frame at this crucial point in
                % time. That would invalidate this trial.
                if (pts - lastpts > 1.5*(1/fps))
                    % Difference to last frame is more than 1.5 times
                    % the expected difference under assumption 'no
                    % skip'. We skipped in the wrong moment!
                    reject=1;
                end;
            end;
            
            % Keep track of the frames pts in order to check for skipped frames:
            lastpts=pts;
            
            % Delete the texture. We don't need it anymore:
            Screen('Close', movietexture);
            movietexture=0;
        end;
        
        % Done with drawing. Check the keyboard for subjects response:
        [keyIsDown, secs, keyCode]=KbCheck;
        if (keyIsDown==1)
            % Abort requested?
            if keyCode(esc)
                % This signals abortion:
                reject=-1;
                % Break out of display loop:
                sca;
            end;
            
            % Space key pressed to indicate detection of event?
            if keyCode(KbName('1')) | keyCode(KbName('1!'))
                % Response too early (before event happened?)
                if (onsettime==-1)
                    % Reject this trial:
                    reject=2;
                else
                    % Valid response: Difference between 'secs' and
                    % 'onsettime' is the reaction time:
                    response=1;
                    reactiontime=secs - flashOnset;
                    reject = 0;
                end;
            end;
            if keyCode(KbName('2')) | keyCode(KbName('2@'))
                % Response too early (before event happened?)
                if (onsettime==-1)
                    % Reject this trial:
                    reject=2;
                else
                    % Valid response: Difference between 'secs' and
                    % 'onsettime' is the reaction time:
                    response=2;
                    reactiontime=secs - flashOnset;
                    reject = 0;
                end;
            end;
            if keyCode(KbName('3')) | keyCode(KbName('3#'))
                % Response too early (before event happened?)
                if (onsettime==-1)
                    % Reject this trial:
                    reject=2;
                else
                    % Valid response: Difference between 'secs' and
                    % 'onsettime' is the reaction time:
                    response=3;
                    reactiontime=secs - flashOnset;
                    reject = 0;
                end;
            end;
        end
    end; % ...of display loop...
    Screen('FillRect', params.win, params.bkground, params.stimArea);
    flashOffset = Screen('Flip', params.win);
    
    % Stop movie playback, in case it isn't already stopped. We do this
    % by selection of a playback rate of zero: This will also return
    % the number of frames that had to be dropped to keep audio, video
    % and realtime in sync.
    droppedcount = Screen('PlayMovie', movie, 0, 0, 0);
    if (droppedcount > 0.2*framecount)
        % Over 20% of all frames skipped?!? Playback problems! We
        % reject this trial...
        reject=4;
    end;
    
    % Close the moviefile.
    Screen('CloseMovie', movie);
    
    
    if (reactiontime==-1 && reject==0)
        reject=3;
        response = 0;
        reactiontime = 0;
    end;
    if (reactiontime==-1 && reject==4)
        reject=4;
        response = 0;
        reactiontime = 0;
    end;
    
    %     % Print out trials result if it was a valid trial:
    %     if (reject==0)
    %         fprintf('Trial %i valid: Reaction time was %f msecs.\n', i, 1000 * reactiontime);
    %     end;
    %
    %     if (reject==1)
    %         fprintf('Trial %i rejected due to skip in video playback at time of event.\n', i);
    %     end;
    %
    %     if (reject==2)
    %         fprintf('Trial %i rejected. False detection by subject.\n', i);
    %     end;
    %
    %     if (reject==3)
    %         fprintf('Trial %i rejected. No detection by subject. Asleep?!?\n', i);
    %     end;
    %
    %     if (reject==4)
    %         fprintf('Trial %i rejected. Way too many skips in movie playback!!!\n', i);
    %     end;
    
    %reject == 0: valid response, made during movie
    %reject == 1: invalid response due to skipped playback at time of event
    %reject == 2: invalid response, subject responded before the event
    %reject == 3: no response during video, going to reaction screen now
    %reject == 4: too many skipped frames in video
    
    % Wait for subject to release keys:
    %KbReleaseWait;
    RestrictKeysForKbCheck([]);
end; % Trial done. Next trial...

