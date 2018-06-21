%addpath('X:\Lab\Labmembers\Simon Kheifets\Signal Extraction\Matlab\From Yoav\Sub functions');
%%
tic
addpath(genpath('/n/cohen_lab/Lab/Computer Code/Image Processing'));
addpath('/n/cohen_lab/Lab/Labmembers/Simon Kheifets/Matlab Code/psd functions/');
addpath('/n/cohen_lab/Lab/Labmembers/Simon Kheifets/Signal Extraction/Matlab/Upright Voltage Imaging Analysis/lib/');
toc
%%
clc;clearvars;close all

thispath = '/n/cohen_lab/Lab/Labmembers/Yoav Adam/Data/In Vivo/Hippocampus/ForSimon/Oriens_IVQ32-S2-FOV6/134107_Tread-3speed_Dilas-8V_488-OD0.0';


%thispath = 'C:\Users\Cohen lab\Documents\Simon K\Oriens_IVQ32-S2-FOV6\134107_Tread-3speed_Dilas-8V_488-OD0.0';
%thispath = 'C:\Users\Cohen lab\Documents\Simon K\PCL_IVQ32-S2-FOV1\115810_Tread-3speed_Dilas-7V_488-OD0.0'; %bright bloodflow interference... able to find 3 cells
%thispath = 'C:\Users\Cohen lab\Documents\Simon K\PCL-IVQ32-S2-FOV2\123339_Tread-3speed_Dilas-8V_488-OD0.0'; %also has distinctive blood vessels
%thispath = 'C:\Users\Cohen lab\Documents\Simon K\PCL_IVQ38-S1-FOV2\104438_Tread-1speed_Dilas-8V_488-OD0.0';
%thispath = 'C:\Users\Cohen lab\Documents\Simon K\PCL_IVQ39-S2-FOV3\203402_Tread-1Speed_Dilas-8V_488-OD0.0';  %three cells, interesting consecutive complex spikes...
%thispath = 'C:\Users\Cohen lab\Documents\Simon K\IVQ11-S3-FOV1\161346_Spont_Dilas-7V_488-OD0.5'; %anesthetized, should have 7 cells
%expfile = fullfile(thispath,'experimental_parameters.txt');
datfile = 'movReg.bin';
label = thispath(38:end); %descriptve string
% datfile = 'Sq_camera.bin';
% [mov0, nrow, ncol]=readBinMov4(thispath,datfile,1);
% mov0=vm(mov0);

%% some basic analysis before truncating and filtering
tic
s1 = makeVMDsettings('Dir',thispath,'File',datfile,'Transpose',1,'DT',1e-3,'Label',label);
vmd = vmd_importData(s1); %load the movie
toc
tic
vmd_basicPlot(vmd); %plot basic info about movie
toc
%% filter the movie
tic
s2 = makeFVMsettings('TLim',[]);
[vmd, f1] = vmd_makeFVM(vmd,s2);
fvm_quickPlot(f1); %plot basic stats/summary
toc

%% do PCA
tic
s3 = makePCAsettings('NPC',20);
p1 = fvm_doPCA(f1,s3);
[handles] = plotPCAresults(p1.uvm,p1.v,p1.d,p1.stats.totvar,['PCA  ' p1.parent.label]);
toc
figure; plotVStats(p1.d,p1.v,p1.stats); %highpass traces
%plotVStats(p1.more.dnp,p1.more.vnp,p1.more.statsnp); %allpass traces
%plotVStats(p1.d,p1.more.vlp,p1.more.statslp); %lowpass traces

%% do ICA
s4 = makeICAsettings('NIC',10,'Alpha',1);
q1 = pc_doICA(p1,s4); %do ICA,save as ICA object
figure; plotPCAresults(q1.footprints,(q1.traces)',diag(10),1,['ICA']);

