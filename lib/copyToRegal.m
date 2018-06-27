function [po status msg] = copyToRegal(ri,ro,rel)
%ri 'root' path in
%ro 'root' path out
%rel struct of paths to be copied relative to ro and ri
np = length(rel); %number of paths
pi = cellfun(@(x) fullfile(ri,x),rel,'UniformOutput',false);
po = cellfun(@(x) fullfile(ro,x),rel,'UniformOutput',false);

for i = 1:np
    [status{i}, msg{i}]=movefile(pi{i},po{i});
end