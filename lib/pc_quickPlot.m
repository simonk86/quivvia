function [h] = pc_quickPlot(p)
%IC_QUICKPLOT plot summary of PCAobj object, 
%Simon Kheifets 6/20/2018
%   Detailed explanation goes here
% todo:
% -fix title
h.fh = figure('Position',[324   145   973   643],'Color','w');
pos1 = [0.0 0 0.6 1];
pos2 = [0.625 0.45 0.35 0.5];
pos3 = [0.625 0.05 0.35 0.3];

h.ahs(1)= subplot('Position',pos1);
set(gca,'Visible','off');
maintitle = ['PCA: ' p.parent.label];
h.imh = stackImshow(p.uvm,'maintitle',...
    maintitle,'subtitles',sprintfc('N=%i',1:p.uvm.frames),...
    'hframe',h.ahs(1),'addcolorbar',1);

h.ahs(2) = subplot('position',pos2);
stackplot(p.v);

h.ahs(3) = subplot('position', pos3);
D = p.d;
tv = p.stats.totvar;
Dc = [0; cumsum(D)];
semilogy(0:1:length(D),(tv-Dc)/tv,'o-');
end

