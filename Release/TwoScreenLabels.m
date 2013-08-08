function TwoScreenLabels(params, left, right,TwoDestinations)

Screen('TextFont',params.win, params.font);
Screen('TextStyle', params.win, 1);
Screen('TextSize', params.win, params.tsize);
Screen('DrawText', params.win, left, (TwoDestinations(1,1)+TwoDestinations(3,1))/2.5, TwoDestinations(4,1) + 50, params.TextColor)%34-139-34 green
%Screen('DrawText', params.win, middle, (ThreeDestinations(1,2)+ThreeDestinations(3,2))/2.08, ThreeDestinations(4,2) + 50, [255 0 0]);%255-0-0 red
Screen('DrawText', params.win, right, (TwoDestinations(1,2)+TwoDestinations(3,2))/2.08, TwoDestinations(4,2) + 50, params.TextColor);%255-255-0 yellow

% Screen('TextFont',params.win, params.font);
% Screen('TextStyle', params.win, 1);
% Screen('TextSize', params.win, params.tsize);
% Screen('DrawText', params.win, left, ThreeDestinations(1,1), 600, [34 139 34])%34-139-34 green
% Screen('DrawText', params.win, middle, 615, 600, [255 0 0]);%255-0-0 red
% Screen('DrawText', params.win, right, 1015, 600, [255 255 0]);%255-255-0 yellow