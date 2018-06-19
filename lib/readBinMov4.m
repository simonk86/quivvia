%load a Bin movie using the info file to get the size.
%No default Bin file name, imput the BinName
function [mov, nrow, ncol]=readBinMov4(BinDir, BinName,flipflg)
tic
clc;
disp('Loading movie...');
% get the frame size
Info=textscan(fopen(fullfile(BinDir,'experimental_parameters.txt')),'%s');
nrow = str2num(Info{1,1}{6,1});
ncol = str2num(Info{1,1}{3,1});
datfile = fullfile(BinDir,BinName);
% read file into tmp vector
fid=fopen(datfile);
% open file
tmp = fread(fid, '*uint16', 'l');       % uint16, little endian
fclose(fid);                            % close file
% reshape vector into appropriately oriented, 3D array
nframe = length(tmp)/(nrow*ncol);

%mov = permute(mov, [2 1 3]);
if flipflg
    mov = reshape(tmp, [nrow ncol nframe]);
else
    mov = reshape(tmp, [ncol nrow nframe]);
    mov = permute(mov, [2 1 3]);
end

toc
end