function [v] = vmd_importData(s)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
%   Simon kheifets 6/3/2008
    v = VMD();
    [mov0, nrow, ncol]=readBinMov4(s.dir,s.file,s.transpose);
    v.mov=vm(mov0);
    v.dt = s.dt;
    v.tvec = s.t0+s.dt*(1:v.mov.frames)-s.dt;
    v.meanimg = v.mov.mean;
    v.meantrace = v.mov.frameAverage;
    v.vartrace = var(double(v.mov(:,:)),0,1)'; %variance of each frame
    v.duration = v.tvec(end);
    if isempty(s.label)
        v.label = s.file;
    else
        v.label = s.label;
    end
    v.set = s;
    
    if s.calcvar
            v.varimg = var(single(v.mov.data),0,3);
    end
end

