function path = savePdfFig(h)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
figure(h.fh);
print -dpdf -painters test
end

