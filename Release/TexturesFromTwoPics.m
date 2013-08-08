function ImageTextures = TexturesFromTwoPics(params, img1, img2)

tex1 = Screen('MakeTexture', params.win, img1);
tex2 = Screen('MakeTexture', params.win, img2);
ImageTextures = [tex1 tex2];

