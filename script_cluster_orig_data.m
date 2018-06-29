addpath('lib');
loadQuivviaDependencies();
%% generate list of paths for the files
clc;clearvars;close all
labpath = labPath();

uprFOVs = [...
    48,2018,05,15,4,1,3;...
    51,2018,05,31,1,1,2;...
    51,2018,05,31,1,1,3;...
    52,2018,05,31,1,1,1;...
    52,2018,05,31,1,1,2]; %ivq# ,y,m,d, session,slice,fov,
basepath = fullfile(labpath, 'Labmembers', 'Yoav Adam', 'Data', 'In Vivo', 'Hippocampus');% 'X:\Lab\Labmembers\Yoav Adam\Data\In Vivo\Hippocampus';

% uprFOVs = [...
%     48,2018,05,15,4,1,3;...
%     %51,2018,05,31,1,1,2;...
%     %51,2018,05,31,1,1,3;...
%     52,2018,05,31,1,1,1;...
%     52,2018,05,31,1,1,2]; %ivq# ,y,m,d, session,slice,fov,
% basepath = fullfile(labpath, 'Labmembers', 'Simon Kheifets', 'Signal Extraction', 'Test Data');% 'X:\Lab\Labmembers\Yoav Adam\Data\In Vivo\Hippocampus';

outputpath = '/n/regal/cohen_lab/skheifets/qvout/test1';
outputstring = 'test_defocus1';
fovpaths = fovPath(uprFOVs);
datfile = 'movReg.bin';

pathsin = cellfun(@(x) fullfile(basepath,x),fovpaths,'UniformOutput',false);
regalbasepath = '/n/regal/cohen_lab/skheifets/tempuprdata/';
%[regalpaths, status, msg] = copyToRegal(basepath,regalbasepath,fovpaths);

%copy and count files

n=1;
jmax = 0;
for i = 1:length(fovpaths)
    fovpath = fovpaths{i};
    %get folders in each fov path
    if ~isdir(fullfile(regalbasepath,fovpath))
        copyToRegal(basepath,regalbasepath,{fovpath});
    end
    info = dir(fullfile(regalbasepath,fovpath));
    folders = {info([info(:).isdir]==1).name};
    dfolders = folders(~cellfun(@isempty,regexp(folders,'[0-9]{6}_')));
    
    if length(dfolders)>jmax
        jmax = length(dfolders); 
    end
    
    for j = 1:length(dfolders)
        
        dfolder = dfolders{j};
        fullpath = fullfile(regalbasepath,fovpath,dfolder);
        fullpaths{n}= fullpath;
        n=n+1;
    end
end
all_fns = cell(length(fovpaths),jmax,5); %cell which will contain paths to pdfs
numfiles = n-1;
n=1;
parpool('local',4);
tic
 parfor i = 1:length(fovpaths)
%for i = 2:2
    fovpath = fovpaths{i};
    %get folders in each fov path
    if ~isdir(fullfile(regalbasepath,fovpath))
        copyToRegal(basepath,regalbasepath,{fovpath});
    end
    info = dir(fullfile(regalbasepath,fovpath));
    folders = {info([info(:).isdir]==1).name};
    dfolders = folders(~cellfun(@isempty,regexp(folders,'[0-9]{6}_')));
    
    for j = 1:length(dfolders)
        close all
        dfolder = dfolders{j};
        fullpath = fullfile(regalbasepath,fovpath,dfolder);
        thislabel = makeVMDLabel(fullfile(fullpath,datfile));
        
        sv = makeVMDsettings('Dir',fullpath,...
            'File',datfile,'Transpose',1,...
            'DT',1e-3,'Label',thislabel,...
            'Crop', [5 0 2 0]);
        sf = makeFVMsettings('TLim',[0.02 10],...
            'RemoveRowNoise',0,'nBin',2,...
            'TBlood',5);
        sp = makePCAsettings('NPC',20);
        si = makeICAsettings('NIC',10,'Alpha',1);
        
        tic
        [vmd, fns] = autoSegment(sv,sf,sp,si);
        toc
        
        savedir = fullfile(vmd.set.dir, 'quivvia');
        fns{5} = unqDirFile(savedir,'qAll','pdf');
        append_pdfs(fns{5},fns{1},fns{2},fns{3},fns{4});
        
        all_fns(i,j,:)=fns;
        
    end
 end
 
 %%
 fn6 = fullfile(outputpath, [outputstring '_VoltageMovieData']);
 fn7 = fullfile(outputpath, [outputstring '_FilteredVoltageMovie']);
 fn8 = fullfile(outputpath, [outputstring '_PCAs']);
 fn9 = fullfile(outputpath, [outputstring '_ICAs']);
 fn10 = fullfile(outputpath, [outputstring '_Everything']);
 
 %do this loop separately at the end, so that the files aren't out of order
 for i = 1:size(all_fns,1)
     for j = 1:size(all_fns,2)
         if ~isempty(all_fns{i,j,1})
         else
             fns = all_fns(i,j,:);
             append_pdfs(fn6,fns{1});
             append_pdfs(fn7,fns{2});
             append_pdfs(fn8,fns{3});
             append_pdfs(fn9,fns{4});
             append_pdfs(fn10,fns{5});
         end
         
     end
 end
 %%
        


toc