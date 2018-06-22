addpath('lib');
loadQuivviaDependencies();
%% generate list of paths for the files
clc;clearvars;close all

uprFOVs = [...
    48,2018,05,15,4,1,3;...
    51,2018,05,31,1,1,2;...
    51,2018,05,31,1,1,3;...
    52,2018,05,31,1,1,1;...
    52,2018,05,31,1,1,2]; %ivq# ,y,m,d, session,slice,fov,

labpath = labPath();
basepath = fullfile(labpath, 'Labmembers', 'Yoav Adam', 'Data', 'In Vivo', 'Hippocampus');% 'X:\Lab\Labmembers\Yoav Adam\Data\In Vivo\Hippocampus';
fovpaths = fovPath(uprFOVs);
datfile = 'movReg.bin';

%get folders in each fov path