function [xq, yq, zq] = PreprocessDate(ImData,d)
%UNTITLED2 数据前处理
%   ImData输入数据格式为[x,y,z]
%   d为网格大小
%% 原始数据
x = ImData(:,1);y = ImData(:,2);z = ImData(:,3); 
%% 3σ原则剔除异常z值
u = z;
mz = mean(u);
sigmaz = std(u);
lower_bound = mz - 3*sigmaz;
upper_bound = mz + 3*sigmaz;
idx = (u >= lower_bound) & (u <= upper_bound);
x = x(idx); y = y(idx); z = z(idx);
%% 数据网格化
%扩大数据范围避免出现外插
maxx = max(x); minx = min(x);
maxy = max(y); miny = min(y);
X = minx : d : maxx;
Y = miny : d : maxy;
% [xm,ym] = meshgrid(X,Y);
r = ceil((maxx - minx)/d) + 1;
c = ceil((maxy - miny)/d) + 1;
n = length(x);
ID = zeros(n,1);
% X = zeros(r,c); Y = zeros(r,c);
% Z = zeros(r,c);
for i = 1 : n
    x0 = x(i); y0 = y(i); 
    %确定点所属节点编号
    rID(i) = floor((y0 - miny)/d) + 1;
    cID(i) = floor((x0 - minx)/d) + 1;
    ID(i) = cID(i)*(r-1) + rID(i);
end
%网格化X,Y,Z数据
[m1,m2] = unique(ID);
xq = zeros(length(m1),1);
yq = zeros(length(m1),1);
zq = zeros(length(m1),1);
for i = 1 : length(m1)
    temp = ID == m1(i);
    %3σ原则平均网格内异常z值
    u = z(temp);
    zq(i) = mean(u);
    xq(i) = (cID(m2(i))-1)*d + minx;
    yq(i) = (rID(m2(i))-1)*d + miny;
end

end

