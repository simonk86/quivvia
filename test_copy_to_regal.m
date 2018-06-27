addpath('lib');
loadQuivviaDependencies();
%% generate list of paths for the files
clc;clearvars;close all
labpath = labPath();

% uprFOVs = [...
%     48,2018,05,15,4,1,3;...
%     51,2018,05,31,1,1,2;...
%     51,2018,05,31,1,1,3;...
%     52,2018,05,31,1,1,1;...
%     52,2018,05,31,1,1,2]; %ivq# ,y,m,d, session,slice,fov,
% basepath = fullfile(labpath, 'Labmembers', 'Yoav Adam', 'Data', 'In Vivo', 'Hippocampus');% 'X:\Lab\Labmembers\Yoav Adam\Data\In Vivo\Hippocampus';

uprFOVs = [...
    48,2018,05,15,4,1,3;...
    %51,2018,05,31,1,1,2;...
    %51,2018,05,31,1,1,3;...
    52,2018,05,31,1,1,1;...
    52,2018,05,31,1,1,2]; %ivq# ,y,m,d, session,slice,fov,
basepath = fullfile(labpath, 'Labmembers', 'Simon Kheifets', 'Signal Extraction', 'Test Data');% 'X:\Lab\Labmembers\Yoav Adam\Data\In Vivo\Hippocampus';

outputpath = fullfile(cd, 'out');
outputstring = 'test_defocus';
fovpaths = fovPath(uprFOVs);
datfile = 'movReg.bin';

n=1;
pathsin = cellfun(@(x) fullfile(basepath,x),fovpaths,'UniformOutput',false);
<<<<<<< HEAD
regalbasepath = fullfile('n','regal','cohen_lab','skheifets','tempUprData');
=======
regalbasepath = '/n/regal/cohen_lab/skheifets/tempuprdata/';
>>>>>>> ccc703ae0b07377f6d09ead79f9c82ff3968dba7
[regalpaths, status, msg] = copyToRegal(basepath,regalbasepath,fovpaths);
