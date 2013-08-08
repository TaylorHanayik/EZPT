function [position] = one_pic_destination(params,vertsize,horizsize)

destRect = [params.winw/2 - horizsize/2 + 0, ... %left
             params.winh/2 - vertsize/2, ... %top
             params.winw/2 + horizsize/2 + 0, ... %right
             params.winh/2 + vertsize/2]'; %bottom

position = destRect;