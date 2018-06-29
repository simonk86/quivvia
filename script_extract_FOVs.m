pathcell = MasterFOV(3,:);
nfov = length(pathcell);

for i = 1:nfov
    this=regexp(pathcell{i},'FOV(\d{1,3})','tokens');
    fovs(i) = str2num(cell2mat(this{1}));
    this = regexp(pathcell{i},'IVQ(\d{1,3})','tokens');
    ivqs(i) = str2num(cell2mat(this{1}));
    this = regexp(pathcell{i},'-S(\d{1,3})','tokens');
    sens(i) = str2num(cell2mat(this{1}));
    this = regexp(pathcell{i},'slice(\d{1,3})','tokens');
    slis(i) = str2num(cell2mat(this{1}));
    ymd = regexp(pathcell{i},'(\d{4})-(\d{2})-(\d{2})_','tokens');
%     ymd = (cell2mat(this{1}));
    years(i)=str2num(ymd{1}{1});
    months(i) = str2num(ymd{1}{2});
    days(i) = str2num(ymd{1}{3});
    
    uprFOVs(i,:)=[ivqs(i) years(i) months(i) days(i) sens(i) slis(i) fovs(i)];
end