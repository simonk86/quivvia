function [h] = fvm_quickPlot(f)
%fvm_quickplot
%   Plot useful information about filtered movie
%Simon kheifets 6/3/2018
h.fh = figure('Position',[100  100  1299    619],'Color','w');

%%

nplots = 9;
nrows = 3;
ncols = 3;
postitle = [0,0.9,1,0.1];
w0 = 1/ncols;
h0 = 0.9/nrows;
ww = (1/ncols)*0.8;
hh = (0.9/nrows)*0.65;
for i = 1:nrows
    b = 0.9-i*h0+0.5*(h0-hh);
    for j=1:ncols
        l = (j-1)*w0+0.5*(w0-ww);
        pos{i,j} = [l b ww hh];
    end
end

        

titletext = ['Filtered voltage movie summary: ' f.parent.label];

axcount = 1;
h.ah(axcount) = subplot('Position',postitle);
h.th = text(0.5, 0.5, titletext, 'Units', 'Normalized',...
    'HorizontalAlignment','Center',...
    'FontUnits','Normalized','FontSize',0.3);
set(gca,'Visible','off')

axcount = axcount+1;
h.ah(axcount) = subplot('Position',pos{1,1});
imagesc(f.meanimg);
daspect([1 1 1]);
colorbar;
colormap(jet);
title('mean img');


axcount = axcount+1;
h.ah(axcount) = subplot('Position',pos{1,2});
imagesc(log10(f.varimg));
daspect([1 1 1]);
colorbar;
colormap(jet);
title('var img');

axcount = axcount+1;
h.ah(axcount) = subplot('Position',pos{1,3});
plot(f.tvec,f.meantrace);
title('frame avg');
%xlabel('Time (s)');
ylabel('counts');

%%
% axcount = axcount+1;
% h.ah(axcount) = subplot('Position',pos{2,1});
%imagesc(f.meanimgHP);
% daspect([1 1 1]);
% colorbar;
% colormap(jet);
% title(f.label);

axcount = axcount+1;
h.ah(axcount) = subplot('Position',pos{2,2});
imagesc(log10(f.varimgHP));
daspect([1 1 1]);
colorbar;
colormap(jet);
title('HP: var img)');

axcount = axcount+1;
h.ah(axcount) = subplot('Position',pos{2,3});
plot(f.tvec,f.meantraceHP);
title('HP: frame avg');
%xlabel('Time (s)');
ylabel('counts');
%%
% axcount = axcount+1;
% h.ah(axcount) = subplot('Position',pos{3,1});
% imagesc(f.meanimgLP);
% daspect([1 1 1]);
% colorbar;
% colormap(jet);
% title(f.label);

axcount = axcount+1;
h.ah(axcount) = subplot('Position',pos{3,2});
imagesc(log10(f.varimgLP));
daspect([1 1 1]);
colorbar;
colormap(jet);
title('LP: var img');

axcount = axcount+1;
h.ah(axcount) = subplot('Position',pos{3,3});
plot(f.tvec,f.meantraceLP);
title('LP: frame avg');
xlabel('Time (s)');
ylabel('counts');
end

