function [xq, yq, zq] = P1(ImData)
%UNTITLED2 数据前处理
%   ImData输入数据格式为[x,y,z]
%   d为网格大小
%% 原始数据
x = ImData(:,1);y = ImData(:,2);z = ImData(:,3); 
% 旋转配准平面
[x,z] = Re(x,z);
%% 3σ原则剔除异常z值
u = z;
mz = mean(u);
sigmaz = std(u);
lower_bound = mz - 3*sigmaz;
upper_bound = mz + 3*sigmaz;
idx = (u >= lower_bound) & (u <= upper_bound);
x = x(idx); y = y(idx); z = z(idx);
%% 数据网格化
x = round(x);y = round(y); %%取整
a = 1000*y+x;
[m,n] = unique(a);
xq=x(n);
yq=y(n);
zq=z(n);

end