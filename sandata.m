function ImpData = sandata(fname)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
impdata = importdata(fname);
idxS = strfind(impdata.textdata, '扫描');
idx1 = find(not(cellfun(@isempty, idxS)));
idx1(1) = [];
ImpData = impdata.data(idx1,:);
x0 = ImpData(:,1); y0 = ImpData(:,3); z0 = ImpData(:,2);
y0 = y0 - max(y0);
x0 = x0-mean([max(x0),min(x0)]);
[y0,z0] = Re(y0,z0);
[x0,z0] = Re(x0,z0);
ImpData = [x0,y0,z0];
end