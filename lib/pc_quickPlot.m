function [h] = pc_quickPlot(p,varargin)
%IC_QUICKPLOT plot summary of PCAobj object, 
%Simon Kheifets 6/20/2018
%   Detailed explanation goes here
% todo:
% -fix title
h.parent = p;

pp = inputParser;
pp.KeepUnmatched = 1;
addParameter(pp,'topdf',0);
parse(pp,varargin{:});
v2struct(pp.Results);
titlesize=0.15; %font size for title

if topdf
    h.fh = figure('Units','inches',...
        'Position',[17 1.5 8.5 11],...
        'Color','w',...
        'PaperPosition',[0 0 8.5 11],...
        'PaperSize',[8.5 11]);
else
    h.fh = figure('Position',[324   145   973   643],'Color','w');
end
pos1 = [0.0 0 0.6 1];
pos2 = [0.625 0.45 0.35 0.45];
pos3 = [0.625 0.05 0.35 0.3];

h.ahs(1)= subplot('Position',pos1);
set(gca,'Visible','off');
maintitle = ['PCA: ' p.parent.label];
h.imh = stackImshow(p.uvm,'maintitle',...
    maintitle,'subtitles',sprintfc('N=%i',1:p.uvm.frames),...
    'hframe',h.ahs(1),'addcolorbar',1);
if topdf
    set(h.imh.thtitle,'FontUnits','inches',...
        'FontSize',titlesize,'Interpreter','none');
end

h.ahs(2) = subplot('position',pos2);
stackplot(p.v,p.parent.tvec);
xlabel('time');
title('component time traces');

h.ahs(3) = subplot('position', pos3);
D = p.d;
tv = p.stats.totvar;
Dc = [0; cumsum(D)];
semilogy(0:1:length(D),(tv-Dc)/tv,'o-');
title('Fractional Variance');
xlabel('Component number');
ylabel('fraction of variance remaining');
end

