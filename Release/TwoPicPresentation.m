function [onsettime, response, reactiontime, reject]=TwoPicPresentation(params, img1, img2)

[ImageTextures] = TexturesFromTwoPics(params, img1, img2);
TwoDestinations = TwoImageDestinations(params);
left = 'Green';
right = 'Yellow';
TwoScreenLabels(params, left, right,TwoDestinations)
Screen('DrawTextures', params.win, ImageTextures, [], TwoDestinations);
[vbl,onsettime] = Screen('Flip', params.win);

if params.respdevice==1
    [response, reactiontime, reject] = KeyBoardResponse(params.respperiod);
elseif params.respdevice==2
    [response, reactiontime, reject] = ButtonResponse(params.respperiod);
end
Screen('Close',ImageTextures);  
Screen('Close');
