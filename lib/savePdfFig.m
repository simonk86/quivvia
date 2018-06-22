function path = savePdfFig(h)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
figure(h.fh);
print -dpdf -painters test

%save to appropriate folder
%do .ps first (to make multiple pages) and then convert to pdf
%determine path from vmd.set.dir
%or save as both ps and pdf, so that ps can be collated for summaries, but
%pdf is available locally within the file structure.
end

