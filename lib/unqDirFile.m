function [thisfilename] = unqDirFile(savedir,str,ext)

mkdir(savedir);



%generate unique filename
stopflag = 0;
i=1;
while ~stopflag
    thisfilename = fullfile(savedir,sprintf([str '_%i.' ext],i));
    if isfile(thisfilename)
        i=i+1;
    else
        stopflag=1;
    end
end

end

