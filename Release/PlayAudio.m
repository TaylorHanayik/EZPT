function [AudStart, StimEnd, ptime] = PlayAudio(params,speakerimg,wavfilename)
esc=KbName('ESCAPE');
[y, freq] = wavread(wavfilename);
ptime = numel(y(:,1))/freq;
wavedata = y';
nrchannels = size(wavedata,1); % Number of rows == number of channels.
%if mono, make stereo for playback
if nrchannels == 1
    wavedata(2,:)=wavedata;
    nrchannels=2;
end

%speakerimg = imread(sprintf('%sspeaker.jpg', picdir));
speakertex = Screen('MakeTexture', params.win, speakerimg);
Screen('DrawTexture', params.win, speakertex, [], params.speakerRect);
Screen('Flip', params.win);


% Try with the 'freq'uency we wanted:
%pahandle = PsychPortAudio('Open', [], [], 0, freq, nrchannels);
pahandle = PsychPortAudio('Open', [], [], 2, freq, nrchannels, 64);

% Fill the audio playback buffer with the audio data 'wavedata':
PsychPortAudio('FillBuffer', pahandle, wavedata);
% Start audio playback for 'repetitions' repetitions of the sound data,
% start it immediately (0) and wait for the playback to start, return onset
% timestamp.
t= GetSecs;
%WaitSecs('UntilTime', t+ptime)
AudStart = PsychPortAudio('Start', pahandle, 1, t+0.01, 1,t + ptime + 0.5);
AudStart = t+0.01;
WaitSecs('UntilTime', t+ptime+0.5)
%startTime = PsychPortAudio('Start', pahandle [, repetitions=1] [, when=0] [, waitForStart=0] [, stopTime=inf] [, resume=0]);
%pause(ptime); %plays audio til the entire clip has been played then ends
StimEnd = GetSecs;
%Screen('Close',speakertex);
PsychPortAudio('Close',pahandle);
Screen('Close');
%save_to_base(0)