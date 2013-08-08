function ImageTextures = TexturesFromThreePics(params, img1, img2, img3)

tex1 = Screen('MakeTexture', params.win, img1);
tex2 = Screen('MakeTexture', params.win, img2);
tex3 = Screen('MakeTexture', params.win, img3);
ImageTextures = [tex1 tex2 tex3];

