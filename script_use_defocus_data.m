addpath(genpath('X:\Lab\Computer Code\Image Processing')); %add path with subfolders
addpath('X:\Lab\Labmembers\Simon Kheifets\Matlab Code\psd functions');
addpath('lib');
%%
clc;clearvars;close all

basepathwin = 'X:\Lab\Labmembers\Yoav Adam\Data\In Vivo\Hippocampus';
paths{1} = 'IVQ48\2018-05-15_IVQ48-S4\slice1\FOV3\130255_Tread_Dilas-8V_488-OD0.0'; %0um
paths{2} = 'IVQ48\2018-05-15_IVQ48-S4\slice1\FOV3\130943_Spont_Dilas-8V_488-OD0.0_DeF-20um'; %-20um
paths{3} = 'IVQ48\2018-05-15_IVQ48-S4\slice1\FOV3\131258_Spont_Dilas-8V_488-OD0.0_DeF-40um';
paths{4} = 'IVQ48\2018-05-15_IVQ48-S4\slice1\FOV3\131448_Spont_Dilas-8V_488-OD0.0';
datfile = 'movReg.bin';

tic
ipath = 4;
s1 = makeVMDsettings('Dir',fullfile(basepathwin, paths{ipath}),'File',datfile,'Transpose',1,'DT',1e-3,'Label',paths{ipath},'Platform','Windows');
vmd = vmd_importData(s1); %load the movie
vmd_basicPlot(vmd); %plot basic info about movie
ipath = 3;
s1 = makeVMDsettings('Dir',fullfile(basepathwin, paths{ipath}),'File',datfile,'Transpose',1,'DT',1e-3,'Label',paths{ipath},'Platform','Windows');
vmd2 = vmd_importData(s1); %load the movie
toc
%% sum the movies from two VMDs
vmd.mov = vmd.mov+vmd2.mov;
vmd_basicPlot(vmd);
%% filter Movie
tic
s2 = makeFVMsettings('TLim',[0.02 10],'RemoveRowNoise',0,'nBin',2,'TBlood',5);
[vmd, f1] = vmd_makeFVM(vmd,s2);
fvm_quickPlot(f1); %plot basic stats/summary
toc
%% do PCA
s3 = makePCAsettings('NPC',20);
tic
p1 = fvm_doPCA(f1,s3);
toc
% pc_quickPlot(p1);
[handles] = plotPCAresults(p1.uvm,p1.v,p1.d,p1.stats.totvar,['PCA  ' p1.parent.label]);
figure; plotVStats(p1.d,p1.v,p1.stats); %highpass traces
%% do ICA
s4 = makeICAsettings('NIC',10,'Alpha',1);
q1 = pc_doICA(p1,s4); %do ICA,save as ICA object
ic_quickPlot(q1);
%% create Units
q1.icells = [1 2]; %tell it which components are cells ... eventually do this by clicking on the figure
vUs = ic_makeUnits(q1); %create units based on icells
vu_calcStats(vUs); %calculate stats...
vu_quickPlot(vUs); %plot basic cell info