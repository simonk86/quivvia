function [vmd] = autoSegment(sv,sf,sp,si)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


vmd = vmd_importData(sv);



h1 = vmd_basicPlot(vmd,'topdf',1);
savePdfFig(h1,vmd,'qvRaw');

fprintf(['Filtering...' newline]);
 [vmd, f1] = vmd_makeFVM(vmd,sf);
 h2 = fvm_quickPlot(f1,'topdf',1);
savePdfFig(h2,vmd,'qvFilt');

fprintf(['PCA...' newline]);
p1 = fvm_doPCA(f1,sp);
h3 = pc_quickPlot(p1);
savePdfFig(h3,vmd,'qvPCA');

q1 = pc_doICA(p1,si);
h4 = ic_quickPlot(q1);
savePdfFig(h4,vmd,'qvICA');

%save the quivvia raw data also
savedir = fullfile(vmd.set.dir, 'quivvia');
thisfilename = unqDirFile(savedir,'vmdObj','mat');
save(thisfilename,'vmd');
end

