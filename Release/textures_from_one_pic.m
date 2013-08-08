function [imgtexture] = textures_from_one_pic(params, img)

tex1 = Screen('MakeTexture', params.win, img);
imgtexture = tex1;
