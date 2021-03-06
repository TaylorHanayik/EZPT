function TwoDestinations = TwoImageDestinations(params)

destRect1 = [params.winw/2 - params.horizsize/2 - 400, ... %left
             params.winh/2 - params.vertsize/2, ... %top
             params.winw/2 + params.horizsize/2 - 400, ... %right
             params.winh/2 + params.vertsize/2]'; %bottom

destRect2 = [params.winw/2 - params.horizsize/2 + 400, ... %left
             params.winh/2 - params.vertsize/2, ... %top
             params.winw/2 + params.horizsize/2 + 400, ... %right
             params.winh/2 + params.vertsize/2]'; %bottom
TwoDestinations = [destRect1 destRect2];
