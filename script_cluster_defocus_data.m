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
%    51,2018,05,31,1,1,2;...
%    51,2018,05,31,1,1,3;...
    52,2018,05,31,1,1,1;...
    52,2018,05,31,1,1,2]; %ivq# ,y,m,d, session,slice,fov,
basepath = fullfile(labpath, 'Labmembers', 'Simon Kheifets', 'Signal Extraction', 'Test Data');% 'X:\Lab\Labmembers\Yoav Adam\Data\In Vivo\Hippocampus';


fovpaths = fovPath(uprFOVs);
datfile = 'movReg.bin';

n=1;
% for i = 1:length(fovpaths)
for i = 2:2
    fovpath = fovpaths{i};
    %get folders in each fov path
    info = dir(fullfile(basepath,fovpath));
    folders = {info([info(:).isdir]==1).name};
    dfolders = folders(~cellfun(@isempty,regexp(folders,'[0-9]{6}_')));
    
    for j = 1:1%length(dfolders)
        close all
        dfolder = dfolders{j};
        fullpath = fullfile(basepath,fovpath,dfolder);
        thislabel = makeVMDLabel(fullfile(fullpath,datfile));
        
        sv = makeVMDsettings('Dir',fullpath,...
            'File',datfile,'Transpose',1,...
            'DT',1e-3,'Label',thislabel,...
            'Crop', [5 0 2 0]);
        sf = makeFVMsettings('TLim',[0.02 1],...
            'RemoveRowNoise',0,'nBin',2,...
            'TBlood',5);
        sp = makePCAsettings('NPC',20);
        si = makeICAsettings('NIC',10,'Alpha',1);
        [vmd, fns] = autoSegment(sv,sf,sp,si);
        
        savedir = fullfile(vmd.set.dir, 'quivvia');
        fn5 = unqDirFile(savedir,'qAll','pdf');
        append_pdfs(fn5,fns{1},fns{2},fns{3},fns{4});

        fullpaths{n}= fullfile(fullpath,'experimental_parameters.txt');
        n=n+1;
    end
end