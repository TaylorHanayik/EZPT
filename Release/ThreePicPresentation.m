function [onsettime, response, reactiontime, reject]=ThreePicPresentation(params, img1, img2, img3)

[ImageTextures] = TexturesFromThreePics(params, img1, img2, img3);
ThreeDestinations = ThreeImageDestinations(params);
left = 'RING';
middle = 'MIDDLE';
right = 'INDEX';
ThreeScreenLabels(params, left, middle, right,ThreeDestinations)
Screen('DrawTextures', params.win, ImageTextures, [], ThreeDestinations);
[vbl,onsettime] = Screen('Flip', params.win);

if params.respdevice==1
    [response, reactiontime, reject] = KeyBoardResponse(params.respperiod);
elseif params.respdevice==2
    [response, reactiontime, reject] = ButtonResponse(params.respperiod);
end
Screen('Close',ImageTextures);  
Screen('Close');
