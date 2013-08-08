function PlayAudioSimple(wavfilename)
[y, freq] = wavread(wavfilename);
ptime = numel(y)/freq;
wavedata = y';
nrchannels = size(wavedata,1); % Number of rows == number of channels.
%if mono, make stereo for playback
if nrchannels == 1
    wavedata(2,:)=wavedata;
    nrchannels=2;
end


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
s = PsychPortAudio('GetStatus', pahandle);
% RestrictKeysForKbCheck(esc);
% Computer_time = GetSecs;
% [secs, keyCode] = KbPressWait([],0, ptime+Computer_time);
% if keyCode(esc)
%     sca;
% end
 pause(ptime); %plays audio til the entire clip has been played then ends
% Stop playback:
%PsychPortAudio('Stop', pahandle);
% Close the audio device:
%PsychPortAudio('Close', pahandle);
% Screen('Close',speakertex);
PsychPortAudio('Close',pahandle);
% StimEnd = GetSecs;
% Screen('Close');