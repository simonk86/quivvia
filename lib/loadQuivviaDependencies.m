function [] = loadQuivviaDependencies()
%add quivvia dependency folders to matlab path
%   Detailed explanation goes here
labpath = labPath();
imgpropath = fullfile(labpath,'Computer Code','Image Processing');
psdpath = fullfile(labpath,...
    'Labmembers','Simon Kheifets', 'Matlab Code', 'psd functions');


addpath(genpath(imgpropath)); %add path with subfolders
addpath(psdpath);
addpath('lib');
end

