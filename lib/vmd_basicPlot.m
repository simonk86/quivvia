function [h] = vmd_basicPlot(v)
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
%   Simon kheifets 6/3/2008
% add...
%   PSD and autocorrelation of mean trace...
%   statistics abt image...
h.fh = figure('Position',[403   447   837   651],'Color','w');
h.ah1 = subplot(3,1,1);
imagesc(v.meanimg);
daspect([1 1 1]);
colorbar;
colormap(jet);
title(v.label);

h.ah1 = subplot(3,1,2);
imagesc(log10(v.varimg));
daspect([1 1 1]);
colorbar;
colormap(jet);
title('Var Image (log)');

h.ah3 = subplot(3,1,3);
plot(v.tvec,v.meantrace);
title('Mean Trace');
xlabel('Time (s)');
ylabel('mean counts');
end

