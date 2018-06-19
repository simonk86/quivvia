classdef ICAobj < handle
    %ICAobj defines a PCA algorithm output as a class, as
    %simply as possible, just so it inherits from handle, and has well
    %defined properties which reflect the type of data/analysis that it
    %stores.
    
    properties
        parent = [];
        set = [];
        timestamp = [];
        nics = [];
        more = [];
        filters = [];
        footprints = [];
        traces = [];
        mixmat = [];
        sepmat = [];
        icells = [];
        stats = [];
    end
    
    methods
    end
end