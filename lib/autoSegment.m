function [vmd] = autoSegment(sv,sf,sp,si)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


vmd = vmd_importData(sv);

h1 = vmd_basicPlot(vmd,'topdf',1);

fprintf(['Filtering...' newline]);
 [vmd, f1] = vmd_makeFVM(vmd,sf);
 h2 = fvm_quickPlot(f1,'topdf',1);


fprintf(['PCA...' newline]);
p1 = fvm_doPCA(f1,sp);
h3 = pc_quickPlot(p1,'topdf',1);


q1 = pc_doICA(p1,si);
h4 = ic_quickPlot(q1,'topdf',1);

fn1 = savePdfFig(h1,vmd,'qvRaw');
fn2 = savePdfFig(h2,vmd,'qvFilt');
fn3 = savePdfFig(h3,vmd,'qvPCA');
fn4 = savePdfFig(h4,vmd,'qvICA');
savedir = fullfile(vmd.set.dir, 'quivvia');
fn5 = unqDirFile(savedir,'qAll','pdf');
append_pdfs(fn5,fn1,fn2,fn3,fn4);
%save the quivvia raw data also
thisfilename = unqDirFile(savedir,'vmdObj','mat');
save(thisfilename,'vmd');
end

