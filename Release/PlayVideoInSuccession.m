     function [reject,onsettime,droppedcount,movieduration] = PlayVideoInSuccession(params, moviename,moviename2,drawdot,dotcolor)

% Open the moviefile and query some infos like duration, framerate,
% width and height of video frames. We could also query the total count of frames in
% the movie, but computing 'framecount' takes long, so avoid to query
% this property if you don't need it!
if nargin < 4
    drawdot = 0;
end
if nargin < 5
    dotcolor = params.bkground;
end

[movie movieduration fps] = Screen('OpenMovie', params.win, moviename,[],1);
Screen('OpenMovie', params.win, moviename2,1);
Screen('PlayMovie', movie, 1, 0, 1.0);
vbl=Screen('Flip', params.win);



movietexture=0;     % Texture handle for the current movie frame.
reactiontime=-1;    % Variable to store reaction time.
lastpts=0;          % Presentation timestamp of last frame.
onsettime=-1;       % Realtime at which the event was shown to the subject.
reject=0;      % Flag which is set to 1 to reject an invalid trial.
timeOfEvent = 0;
while(movietexture>=0)%&& reactiontime==-1)
    
    
    % The 0 - flag means: Don't wait for arrival of new frame, just
    % return a zero or -1 'movietexture' if none is ready.
    [movietexture pts] = Screen('GetMovieImage', params.win, movie, 0);
    
    % Is it a valid texture?
    if (movietexture>0)
        % Yes. Draw the texture into backbuffer:
        Screen('DrawTexture', params.win, movietexture,[],params.vidRect);
        if drawdot
            %DrawFormattedText(params.win,num2str(num2draw), params.rect(3)-params.rect(3)*.05, params.rect(4)-params.rect(3)*.05,[90 90 90], 60);
            Screen('FillOval', params.win,dotcolor, [0 0 60 60]);
        end
        
        % Flip the display to show the image at next retrace:
        % vbl will contain the exact system time of image onset on
        % screen: This should be accurate in the sub-millisecond
        % range.
        vbl=Screen('Flip', params.win,vbl+0.03);
        % Is this the event video frame we've been waiting for?
        if onsettime==-1 && pts >= timeOfEvent
            % Yes: This is the first frame with a pts timestamp that is
            % equal or greater than the timeOfEvent, so 'vbl' is
            % the exact time when the event was presented to the
            % subject. Define it as onsettime:
            onsettime = vbl;
            
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
    end
end; % ...of display loop...

droppedcount = Screen('PlayMovie', movie, 0, 0, 0);

Screen('CloseMovie', movie);
%Screen('Close');



