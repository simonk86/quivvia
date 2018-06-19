function [h] = fvm_quickPlot(f)
%fvm_quickplot
%   Plot useful information about filtered movie
%Simon kheifets 6/3/2018
h.fh = figure('Position',[207  384        1299         619],'Color','w');

%%
h.ah1 = subplot(3,3,1);
imagesc(f.meanimg);
daspect([1 1 1]);
colorbar;
colormap(jet);
title(f.label);


h.ah1 = subplot(3,3,2);
imagesc(log10(f.varimg));
daspect([1 1 1]);
colorbar;
colormap(jet);
title('Var Image (log)');

h.ah2 = subplot(3,3,3);
plot(f.tvec,f.meantrace);
title('Mean Trace');
xlabel('Time (s)');
ylabel('mean counts');

%%
h.ah4 = subplot(3,3,4);
imagesc(f.meanimgHP);
daspect([1 1 1]);
colorbar;
colormap(jet);
title(f.label);

h.ah5 = subplot(3,3,5);
imagesc(log10(f.varimgHP));
daspect([1 1 1]);
colorbar;
colormap(jet);
title('Var Image (log)');

h.ah6 = subplot(3,3,6);
plot(f.tvec,f.meantraceHP);
title('Mean Trace');
xlabel('Time (s)');
ylabel('mean counts');
%%
h.ah7 = subplot(3,3,7);
imagesc(f.meanimgLP);
daspect([1 1 1]);
colorbar;
colormap(jet);
title(f.label);

h.ah8 = subplot(3,3,8);
imagesc(log10(f.varimgLP));
daspect([1 1 1]);
colorbar;
colormap(jet);
title('Var Image (log)');

h.ah9 = subplot(3,3,9);
plot(f.tvec,f.meantraceLP);
title('Mean Trace');
xlabel('Time (s)');
ylabel('mean counts');
end

