%addpath('X:\Lab\Labmembers\Simon Kheifets\Signal Extraction\Matlab\From Yoav\Sub functions');
addpath(genpath('X:\Lab\Computer Code\Image Processing')); %add path with subfolders
addpath('X:\Lab\Labmembers\Simon Kheifets\Matlab Code\psd functions');
addpath('X:\Lab\Labmembers\Simon Kheifets\Signal Extraction\Matlab\Upright Voltage Imaging Analysis\lib');
addpath('lib');
%addpath('X:\Lab\Labmembers\Yoav Adam\Scripts\NoRMCorre-master');
%%
clc;clearvars;close all

thispath = 'C:\Users\Cohen lab\Documents\Simon K\Oriens_IVQ32-S2-FOV6\134107_Tread-3speed_Dilas-8V_488-OD0.0';
%thispath = 'C:\Users\Cohen lab\Documents\Simon K\PCL_IVQ32-S2-FOV1\115810_Tread-3speed_Dilas-7V_488-OD0.0'; %bright bloodflow interference... able to find 3 cells
%thispath = 'C:\Users\Cohen lab\Documents\Simon K\PCL-IVQ32-S2-FOV2\123339_Tread-3speed_Dilas-8V_488-OD0.0'; %also has distinctive blood vessels
%thispath = 'C:\Users\Cohen lab\Documents\Simon K\PCL_IVQ38-S1-FOV2\104438_Tread-1speed_Dilas-8V_488-OD0.0';
%thispath = 'C:\Users\Cohen lab\Documents\Simon K\PCL_IVQ39-S2-FOV3\203402_Tread-1Speed_Dilas-8V_488-OD0.0';  %three cells, interesting consecutive complex spikes...
%thispath = 'C:\Users\Cohen lab\Documents\Simon K\IVQ11-S3-FOV1\161346_Spont_Dilas-7V_488-OD0.5'; %anesthetized, should have 7 cells
%expfile = fullfile(thispath,'experimental_parameters.txt');
% datfile = 'movReg_5s-15s_truncated.bin';
%datfile = 'Sq_camera_5s-15s_truncated.bin';
label = thispath(38:end);
 datfile = 'Sq_camera.bin';
% [mov0, nrow, ncol]=readBinMov4(thispath,datfile,1);
% mov0=vm(mov0);

%% some basic analysis before truncating and filtering
s1 = makeVMDsettings('Dir',thispath,'File',datfile,'Transpose',0,'DT',1e-3,'Label',label);
vmd = vmd_importData(s1); %load the movie
vmd_basicPlot(vmd); %plot basic info about movie
%% calculate and plot spectrogram
sgrm = vmd_calcSgrm(vmd);
h1 = vmd_plotSgrm(sgrm);
%% perform the row removal
mov2 = rmRowNoise(vmd.mov,vmd.tvec);
vmd2 = vmd_importData(s1); %easier because copy fn does not exist for handle objects
vmd2.mov = mov2;
sgrm2 = vmd_calcSgrm(vmd2);
figure;

h2 = vmd_plotSgrm(sgrm2);

%% plot comparison of the two spectra
figure('Position',[459    88   621   710]);
subplot(2,1,1);
loglog(h1.xbin, h1.ybin);
hold on;
plot(h2.xbin, h2.ybin);
legend({'raw';'filtered'});
xlabel('frequency (Hz)');
ylabel('PSD (counts^2/Hz)');
xlim([10 500]);
%set(gca,'YScale','lin')

% plot comparison of the two cumulative spectra
subplot(2,1,2);
f = sgrm.fvm; Svm1 = sgrm.Svm; Svm2 = sgrm2.Svm;
semilogx(f(f>10),cumsum(Svm1(f>10)));
hold on;
semilogx(f(f>10),cumsum(Svm2(f>10)));
xlim([10 500]);

title('cumulative power');
xlabel('frequency (Hz)');
ylabel('variance (counts^2)');