function [h] = ic_quickPlot(q)
%IC_QUICKPLOT plot summary of ICAobj object, aka results of ICA done on the
%output of PCA analysis
%Simon Kheifets 6/20/2018
%   Detailed explanation goes here
% todo:
% -fix title
h.fh = figure('Position',[324   145   973   643],'Color','w');

h.ahs(1)= subplot('Position',[0.0 0 0.6 1]);
set(gca,'Visible','off');
maintitle = ['ICA: ' q.parent.parent.label];
h.imh = stackImshow(q.footprints,'maintitle',...
   maintitle,'subtitles',sprintfc('N=%i',1:q.footprints.frames),...
    'hframe',h.ahs(1),'addcolorbar',1);

h.ahs(2) = subplot('position',[0.625 0.45 0.35 0.5]);
stackplot(q.traces');

h.ahs(3) = subplot('position', [0.625 0.05 0.35 0.3]);
D = q.parent.d;
tv = q.parent.stats.totvar;
Dc = [0; cumsum(D)];
semilogy(0:1:length(D),(tv-Dc)/tv,'o-');
end

