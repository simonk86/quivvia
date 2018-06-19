classdef VMD < handle
    %VMD defines a voltage movie data class as
    %simply as possible, just so it inherits from handle, and has well
    %defined properties which reflect the type of data/analysis that it
    %stores.
    
    properties
        set = []; %import settings
        mov = [];
        label = [];
        tvec = [];
        dt = [];
        duration = [];
        meanimg = [];
        varimg = [];
        meantrace = [];
        info = [];
        fvm = [];
    end
    
    methods
    end
end
