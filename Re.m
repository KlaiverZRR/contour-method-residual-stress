function [X,Z] = Re(x,z)
%Re 二维旋转矩阵，将平面旋转到基准平面用于配准
p1 = polyfit(x,z,1);
theta = -atan(p1(1));
M = [cos(theta),-sin(theta);sin(theta),cos(theta)];
I = [x, z]*M';
X = I(:,1);
Z = I(:,2)-p1(2);
end