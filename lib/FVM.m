classdef FVM < handle
    %FVM defines the filtered voltage movie class as
    %simply as possible, just so it inherits from handle, and has well
    %defined properties which reflect the type of data/analysis that it
    %stores.
    
    properties
        parent = [];
        set = [];
        mov = [];
        tvec = [];
        spectrogram = [];
        meanimg = [];
        meantrace = [];
        duration = [];
        label = [];
        varimg = [];
        dmov = [];
        movHP = [];
        movLP = [];
        meanimgHP = [];
        meanimgLP = [];
        varimgHP = [];
        varimgLP = [];
        meantraceHP = [];
        meantraceLP = [];
        PCAobj = [];
        ICAobj = [];
    end
    
    methods
    end
end

        