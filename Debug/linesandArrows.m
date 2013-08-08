% control a line on a screen using arrow buttons

esc = KbName('ESCAPE');
background=[0, 0, 0];
screen = max(Screen('Screens'));
[win,rect] = Screen('OpenWindow',win,background);
%keyIsDown=KbCheck;
[keyIsDown, secs, keyCode]=KbCheck;


while keyIsDown

    if keyCode==KbName('RightArrow')
        
        %Start drawing line to the right
        %Use drawlines function??? 
        %How can continuous drawing be done?
        

    end
    
    if keyCode==KbName('LeftArrow')
        
        %Start drawing line to the left

    end
    
    if keyCode==KbName('DownArrow')
        
        %Start drawing line downward

    end
    
    if keyCode==KbName('UpArrow')
        
        %Start drawing line upward

    end

    if keyCode==KbName(esc)
        
        %exit the program
        
        sca;
    end

end



