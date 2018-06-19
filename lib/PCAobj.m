classdef PCAobj < handle
    %PCAobj defines a PCA algorithm output as a class, as
    %simply as possible, just so it inherits from handle, and has well
    %defined properties which reflect the type of data/analysis that it
    %stores.
    
    properties
        parent = [];
        set = [];
        timestamp = [];
        uvm = [];
        d = [];
        v = [];
        npc = [];
        stats = [];
        more = []; %other outputs which may change during testing
        ICAobj = [];

    end
    
    methods
    end
end
