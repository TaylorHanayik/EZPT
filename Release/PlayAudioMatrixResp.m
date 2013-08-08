function [response, reactiontime, reject, t1, ptime] = PlayAudioMatrixResp(params,speakerimg,mat2play,sr)

%[y, freq] = wavread(wavfilename);'
if nargin<5
    sr=44100;
end
y=mat2play;
freq=sr;
ptime = numel(y)/freq;
wavedata = y';
nrchannels = size(wavedata,1); % Number of rows == number of channels.
%if mono, make stereo for playback
if nrchannels == 1
    wavedata(2,:)=wavedata;
    nrchannels=2;
end
% for speaker pic

% params.winWidth = rect(3);
% params.winHeight = rect(4);
% vertsize=330; %old value = 330
% horizsize=330;
% speakerd = [params.winWidth/2 - horizsize + 150, ... %left
%               params.winHeight/2 - vertsize/2, ... %top
%               params.winWidth/2 + horizsize + 150, ... %right
%               params.winHeight/2 + vertsize/2]'; %bottom

%speakerimg = imread(sprintf('%sspeaker.jpg', picdir));
speakertex = Screen('MakeTexture', params.win, speakerimg);
Screen('DrawTexture', params.win, speakertex, [], params.picRect);
Screen('Flip', params.win);


try
    % Try with the 'freq'uency we wanted:
    %pahandle = PsychPortAudio('Open', [], [], 0, freq, nrchannels);
    pahandle = PsychPortAudio('Open', [], [], 2, freq, nrchannels, 64);
catch
    % Failed. Retry with default frequency as suggested by device:
    fprintf('\nCould not open device at wanted playback frequency of %i Hz. Will retry with device default frequency.\n', freq);
    fprintf('Sound may sound a bit out of tune, ...\n\n');

    psychlasterror('reset');
    pahandle = PsychPortAudio('Open', [], [], 0, [], nrchannels);
end
% Fill the audio playback buffer with the audio data 'wavedata':
PsychPortAudio('FillBuffer', pahandle, wavedata);
% Start audio playback for 'repetitions' repetitions of the sound data,
% start it immediately (0) and wait for the playback to start, return onset
% timestamp.
t1 = PsychPortAudio('Start', pahandle, 1, 0, 1);
%startTime = PsychPortAudio('Start', pahandle [, repetitions=1] [, when=0] [, waitForStart=0] [, stopTime=inf] [, resume=0]);


[response, reactiontime, reject] = KeyBoardResponse(ptime);

Screen('Close',speakertex);
PsychPortAudio('Close',pahandle);
%StimEnd = GetSecs;
end