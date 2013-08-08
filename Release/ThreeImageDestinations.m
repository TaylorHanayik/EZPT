function ThreeDestinations = ThreeImageDestinations(params)

destRect1 = [params.winw/2 - params.horizsize/2 - 350, ... %left
             params.winh/2 - params.vertsize/2, ... %top
             params.winw/2 + params.horizsize/2 - 350, ... %right
             params.winh/2 + params.vertsize/2]'; %bottom
destRect2 = [params.winw/2 - params.horizsize/2 + 0, ... %left
             params.winh/2 - params.vertsize/2, ... %top
             params.winw/2 + params.horizsize/2 + 0, ... %right
             params.winh/2 + params.vertsize/2]'; %bottom
destRect3 = [params.winw/2 - params.horizsize/2 + 350, ... %left
             params.winh/2 - params.vertsize/2, ... %top
             params.winw/2 + params.horizsize/2 + 350, ... %right
             params.winh/2 + params.vertsize/2]'; %bottom
ThreeDestinations = [destRect1 destRect2 destRect3];
