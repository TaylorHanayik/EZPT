function [response, reactiontime, reject, screenon] = ResponseScreen(params)
%update: Reponse device can always be set to 1 from now on and the setting
%of 2 will eventually be deleted. The KeyBoardResponse function now
%supports both the keyboard and the buttons. 

period = params.respperiod;
%Screen('FillRect', params.win);
Screen('TextSize', params.win, params.tsize);
DrawFormattedText(params.win, params.prompt , 'center', 'center',params.TextColor, 40);
 [VBL, screenon]=Screen('Flip',params.win);
if params.respdevice==1
    [response, reactiontime, reject] = KeyBoardResponse(period);
elseif params.respdevice==2
    [response, reactiontime, reject] = ButtonResponse(period);
end
RestrictKeysForKbCheck([]);
%[response, reactiontime, reject] = KeyBoardResponse(period);
