function ThreeScreenLabels(params, left, middle, right,ThreeDestinations)

Screen('TextFont',params.win, params.font);
Screen('TextStyle', params.win, 1);
Screen('TextSize', params.win, 24);
Screen('DrawText', params.win, left, (ThreeDestinations(1,1)+ThreeDestinations(3,1))/2.5, ThreeDestinations(4,1) + 50, [0 0 0])%34-139-34 green
Screen('DrawText', params.win, middle, (ThreeDestinations(1,2)+ThreeDestinations(3,2))/2.2, ThreeDestinations(4,2) + 50, [0 0 0]);%255-0-0 red
Screen('DrawText', params.win, right, (ThreeDestinations(1,3)+ThreeDestinations(3,3))/2.08, ThreeDestinations(4,3) + 50, [0 0 0]);%255-255-0 yellow

% Screen('TextFont',params.win, params.font);
% Screen('TextStyle', params.win, 1);
% Screen('TextSize', params.win, params.tsize);
% Screen('DrawText', params.win, left, ThreeDestinations(1,1), 600, [34 139 34])%34-139-34 green
% Screen('DrawText', params.win, middle, 615, 600, [255 0 0]);%255-0-0 red
% Screen('DrawText', params.win, right, 1015, 600, [255 255 0]);%255-255-0 yellow